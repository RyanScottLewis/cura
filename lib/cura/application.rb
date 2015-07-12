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
  require "cura/event/mouse_down"
  require "cura/event/mouse_up"
  require "cura/event/mouse_wheel_down"
  require "cura/event/mouse_wheel_up"
  require "cura/event/resize"
  require "cura/event/selected"
  
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
      
      setup_adapter
      
      @running = false
      @cursor = Cursor.new(application: self)
      @pencil = Pencil.new
      @event_dispatcher = Event::Dispatcher.new(application: self)
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
    def adapter=(value)
      # TODO: Raise error if ever set more than once
      raise TypeError, "adapter must be a Cura::Adapter" unless value.is_a?(Cura::Adapter)
      
      @adapter = value
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
    attr_reader :event_dispatcher
    
    # Run this application.
    #
    # @return [Application] This application.
    def run
      @running = true
      
      run_event_loop
      
      self
    ensure
      @adapter.cleanup
    end
    
    # Stop the application.
    #
    # @return [Application] This application.
    def stop
      @running = false
      
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
      @event_dispatcher.target
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
      @event_dispatcher.target = component
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
      @event_dispatcher.dispatch_event(event, options)
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

    # TODO: Should be in Window
    def top_most_component_at(options={})
      options = { x: 0, y: 0 }.merge(options.to_h)

      # TODO: Focused window? Or some way of determining which window so use top_most_component_at with
      windows.first.children(true).reverse.find do |child|
        (child.absolute_x..child.absolute_x + child.width).include?(options[:x]) &&
          (child.absolute_y..child.absolute_y + child.width).include?(options[:y])
      end
    end

    protected
    
    def setup_adapter
      if @adapter.nil?
        adapter_class ||= Adapter.all.first
        raise Error::InvalidAdapter if adapter_class.nil?
        
        @adapter = adapter_class.new
      end
      
      @adapter.setup
    end
    
    def run_event_loop
      while @running
        update
        draw
        event_dispatcher.run
      end
    end
    
  end
  
end
