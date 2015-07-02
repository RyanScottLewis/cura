if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/attributes/has_windows'
  require 'cura/attributes/has_events'
  require 'cura/attributes/has_initialize'
  
  require 'cura/component/base'
  
  require 'cura/event/dispatcher'
  
  require 'cura/event/click'
  require 'cura/event/focus'
  require 'cura/event/unfocus'
  require 'cura/event/handler'
  require 'cura/event/key_down'
  require 'cura/event/resize'
  require 'cura/event/selected'
  
  require 'cura/error/invalid_adapter'
    
  require 'cura/cursor'
  require 'cura/pencil'
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
      @cursor = Cursor.new( application: self )
      @pencil = Pencil.new
      @event_dispatcher = Event::Dispatcher.new( application: self )
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
      raise TypeError, 'adapter must be a Cura::Adapter' unless value.is_a?(Cura::Adapter)
      
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
    
    # Check if this application is running.
    # 
    # @return [Boolean]
    def running?
      @running
    end
    
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
    
    # Get the currently focused component.
    # 
    # @return [Component::Base]
    attr_reader :focused
    
    # Set focus to a component.
    # 
    # There can only be one component focused at a time within an application, if any.
    # All dispatched events are sent to the currently focused component, or the application if no component is focused.
    # 
    # @param [nil, Component::Base] component
    # @return [Component::Base]
    def focus(component)
      raise TypeError, 'component must be nil or be a Cura::Component::Base' unless component.nil? || component.is_a?(Cura::Component::Base)
      
      dispatch_event( :unfocus, target: @focused ) unless @focused.nil?
      
      @event_dispatcher.target = component.nil? ? self : component
      @focused = component
      
      dispatch_event( :focus, target: component )
      
      component
    end
    
    # Dispatch an event.
    # 
    # @param [#to_sym] name The name of the event class to create an instance of.
    # @return [Event::Base] The dispatched event.
    def dispatch_event( event_name, options={})
      options = options.to_hash rescue options.to_h
      
      @event_dispatcher.target = options[:target] if options.has_key?(:target)
      event = Event.new_from_name(event_name)
      
      @event_dispatcher.dispatch_event(event)
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
