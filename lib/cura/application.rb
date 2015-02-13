module Cura
  
  # An application.
  class Application
    
    class << self
      
      def run
        new.run
      end
      
    end
    
    include Attributes::HasAttributes
    include Attributes::HasWindows
    include Attributes::HasEvents
    
    def initialize(attributes={})
      super
      
      adapter.setup
      
      @running = false
      @redraw = true
      @wait_time = 10
      @cursor = Cursor.new( application: self )
      @pencil = Pencil.new
      @event_dispatcher = Event::Dispatcher.new( self )
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
    
    # Get the time to wait for events in milliseconds.
    # TODO: Should be on dispatcher?
    # 
    # @return [Integer]
    attr_reader :wait_time
    
    # Set the time to wait for events in milliseconds.
    # Set to 0 to wait forever.
    # TODO: Should be on dispatcher?
    # 
    # @param [#to_i] value The new value.
    # @return [Integer]
    def wait_time=(value)
      # TODO: TypeError, :to_i
      value = value.to_i
      value = 0 if value < 0
      
      @wait_time = value
    end
    
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
      is_polling = wait_time == 0 ? true : false
      
      while @running
        update
        
        # TODO: Should send to a "draw" queue?
        draw if redraw?
        
        is_polling ? event_dispatcher.poll : event_dispatcher.peek(wait_time)
      end
      
      self
    ensure
      adapter.cleanup
      
      self
    end
    
    # Stop the application.
    # 
    # @return [Application] This application.
    def stop
      @running = false
      
      self
    end
    
    # Get the currently focused component.
    attr_reader :focused
    
    # Set focus to a component.
    # 
    # There can only be one component focused at a time within an application, if any.
    # All dispatched events are sent to the currently focused component, or the application if no component is focused.
    def focus(component)
      raise TypeError, 'component must be nil or be a Cura::Component' unless component.nil? || component.is_a?(Cura::Component)
      
      dispatch_event( :unfocus )
      
      event_dispatcher.target = component.nil? ? self : component
      @focused = component
      
      dispatch_event( :focus, target: component )
      
      component
    end
    
    # Dispatch an event.
    # 
    # @param [#to_sym] name The name of the event class to create an instance of.
    # @return [Event::Base] The dispatched event.
    def dispatch_event(event_name)
      event = Event.new_from_name(event_name) # TODO: If an Event is passed, send it right through
      
      event_dispatcher.dispatch_event(event)
    end
    
  end
  
end
