if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"
  require "cura/attributes/has_windows"
  require "cura/attributes/has_events"
  require "cura/attributes/has_initialize"

  require "cura/component/base"

  require "cura/event/dispatcher"

  require "cura/event/click"
  require "cura/event/focus"
  require "cura/event/unfocus"
  require "cura/event/handler"
  require "cura/event/key_down"
  require "cura/event/mouse_button"
  require "cura/event/mouse_wheel_down"
  require "cura/event/mouse_wheel_up"
  require "cura/event/resize"
  require "cura/event/selected"

  require "cura/event/middleware/dispatch"
  require "cura/event/middleware/aimer/mouse_focus"
  require "cura/event/middleware/aimer/target_option"
  require "cura/event/middleware/aimer/dispatcher_target"
  require "cura/event/middleware/translator/mouse_click"

  require "cura/error/invalid_adapter"

  require "cura/cursor"
  require "cura/pencil"
end

module Cura
  # An application.
  class Application
    class << self
      def run(attributes={})
        new(attributes).run
      end
    end

    include Attributes::HasInitialize
    include Attributes::HasAttributes
    include Attributes::HasWindows
    include Attributes::HasEvents

    def initialize(attributes={})
      super

      # setup_adapter

      @running = false
      @cursor = Cursor.new(application: self)
      @pencil = Pencil.new

      setup_adapter
      setup_dispatcher
    end

    # Get the adapter used for running this application.
    #
    # @return [Adapter]
    attr_reader :adapter

    # Set the adapter used for running this application.
    # This cannot be set after #run is used.
    #
    # @param [Adapter] value The new adapter.
    # @return [Adapter]
    def adapter=(adapter)
      @adapter = validate_adapter(adapter)
    end

    # Get the text cursor.
    #
    # @return [Cursor]
    attr_reader :cursor

    # Get the pencil used for drawing.
    #
    # @return [Pencil]
    attr_reader :pencil

    # Get the event dispatcher.
    #
    # @return [Event::Dispatcher]
    attr_reader :dispatcher

    # Run this application.
    #
    # @return [Application] This application.
    def run
      run_event_loop

      self
    ensure
      unless @cleaned
        @adapter.cleanup
        @cleaned = true
      end
    end

    # Stop the application after the current run cycle.
    #
    # @return [Application] This application.
    def stop
      @running = false

      self
    end

    # Stop the application immediently.
    #
    # @return [Application] This application.
    def stop!
      @running = false

      @adapter.cleanup
      @cleaned = true

      self
    end

    # Check if this application is running.
    #
    # @return [Boolean]
    def running?
      @running
    end

    # Get the currently focused component.
    #
    # @return [Component::Base]
    def focused
      @dispatcher.target
    end

    # Set focus to a component.
    #
    # There can only be one component focused at a time within an application, if any.
    # All dispatched events are sent to the currently focused component, or the application if no component is focused.
    #
    # @param [nil, Component::Base] component
    # @return [Component::Base]
    def focus(component)
      raise TypeError, "component must be nil or be a Cura::Component::Base" unless component.nil? || component.is_a?(Cura::Component::Base)

      dispatch_event(:unfocus)
      @dispatcher.target = component
      dispatch_event(:focus)

      component
    end

    # Dispatch an event.
    #
    # @param [#to_sym] event The name of the event class to create an instance of or an event instance.
    # @param [#to_hash, #to_h] options
    # @option options [#to_i] :target The optional target of the event.
    # @return [Event::Base] The dispatched event.
    def dispatch_event(event, options={})
      @dispatcher.dispatch_event(event, options)
    end

    # Add a window to this application.
    #
    # @param [Window] window
    # @return [Window]
    def add_window(window)
      super

      window.application = self

      window
    end

    # Update all windows.
    #
    # @return [Application]
    def update
      update_windows
      cursor.update

      self
    end

    # Draw all windows.
    #
    # @return [Application]
    def draw
      draw_windows

      self
    end

    # Instance inspection.
    #
    # @return [String]
    def inspect
      "#<#{self.class}>"
    end

    protected

    def setup_adapter
      if @adapter.nil?
        adapter_class ||= Adapter.all.first
        raise Error::InvalidAdapter if adapter_class.nil?

        @adapter = adapter_class.new
      end

      # TODO: If a class is given, run .new on it first
      # TODO: Adapter.name(*arguments) which defaults to an underscore'd version of the class constant
      # TODO: Adapter.find_by_name
      # TODO: Use Adapter.find_by_name here to allow passing of a Symbol to #adapter=

      @adapter.setup
    end

    def setup_dispatcher
      @dispatcher = Event::Dispatcher.new(application: self)

      @dispatcher.middleware << Event::Middleware::Aimer::MouseFocus.new
      @dispatcher.middleware << Event::Middleware::Aimer::TargetOption.new
      @dispatcher.middleware << Event::Middleware::Aimer::DispatcherTarget.new
      @dispatcher.middleware << Event::Middleware::Dispatch.new
      @dispatcher.middleware << Event::Middleware::Translator::MouseClick.new
    end

    def validate_adapter(adapter)
      # TODO: Raise error if ever set more than once?
      raise Error::InvalidAdapter unless adapter.is_a?(Cura::Adapter)

      adapter
    end

    def run_event_loop
      @running = true

      while @running
        update
        draw
        dispatcher.run
      end
    end
  end
end
