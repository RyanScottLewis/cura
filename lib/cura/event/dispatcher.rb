module Cura
  module Event
    
    # Polls or peeks for events since the last execution and dispatches them to the appropriate component.
    class Dispatcher
      
      # @param Cura::Attributes::HasEvents] target
      def initialize(target)
        self.target = target
      end
      
      # Get the object with an event handler to dispatch events to.
      # 
      # @return [Cura::Attributes::HasEvents]
      attr_reader :target
      
      # Set the object with an event handler to dispatch events to.
      # 
      # @param [Cura::Attributes::HasEvents] value
      # @return [Cura::Attributes::HasEvents]
      def target=(value)
        raise TypeError, 'target must be a Cura::Attributes::HasEvents' unless target.is_a?(Attributes::HasEvents)
        
        @target = value
      end
      
      # Wait forever for an event and handle it.
      # 
      # @return [Event::Base] The event
      def poll
        event = adapter.poll_event
        
        dispatch_event(event)
      end
      
      # Wait a set amount of time for an event and handle it if needed.
      # 
      # @param [#to_i] milliseconds The amount of time to wait in milliseconds.
      # @return [nil, Event::Base] The event, if handled.
      def peek(milliseconds=100)
        event = adapter.peek_event( milliseconds.to_i )
        
        dispatch_event(event) unless event.nil?
      end
      
      # Dispatch an event to the target or application, if the target is nil.
      # 
      # @param [Event::Base] event
      # @return [Event::Base] The event.
      def dispatch_event(event)
        raise TypeError, 'event must be an Event::Base' unless event.is_a?(Event::Base)
        
        event.target = @target
        @target.event_handler.handle( event )
        
        event
      end
      
    end
    
  end
end
