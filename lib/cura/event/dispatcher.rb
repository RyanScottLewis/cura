module Cura
  module Event
    
    # Polls for events since the last execution and dispatches them to the appropriate widget.
    class Dispatcher
      
      include Attributes::HasAttributes
      include Attributes::HasApplication
      
      def initialize(attributes={})
        super
        
        raise ArgumentError, 'application must be set' if application.nil?
      end
      
      # The widget to send the event to.
      # 
      # @return [Object]
      attr_reader :target
      
      # Set the target for events.
      # 
      # @param [nil, #event_handler] The new value.
      # @return [Object]
      def target=(value)
        raise TypeError, 'target must be nil or respond to #event_handler' unless target.nil? || target.respond_to?(:event_handler)
        
        @target = value
      end
      
      # Poll for an event and handle it.
      # 
      # @return [nil, Event::Base] The event, if handled.
      def poll
        event = convert_termbox_event_to_term_ui_event( Termbox.poll_event )
        
        dispatch_event(event) unless event.nil?
      end
      
      # Wait a set amount of time for an event and handle it if needed.
      # 
      # @param [#to_i] milliseconds The amount of time to wait in milliseconds.
      # @return [nil, Event::Base] The event, if handled.
      def peek(milliseconds=100)
        raise TypeError, 'milliseconds must respond to #to_i' unless milliseconds.respond_to?(:to_i)
        milliseconds = milliseconds.to_i
        
        event = convert_termbox_event_to_term_ui_event( Termbox.peek_event(milliseconds) )
        
        dispatch_event(event) unless event.nil?
      end
      
      # Dispatch an event to the target or application, if the target is nil.
      # 
      # @param [Event::Base] event
      # @return [Event::Base] The event.
      def dispatch_event(event)
        raise TypeError, 'event must be an Event::Base' unless event.is_a?(Event::Base)
        
        event.target = target.nil? ? application : target
        event.target.event_handler.handle( event )
        
        event
      end
      
      protected
      
      def convert_termbox_event_to_term_ui_event(termbox_event)
        return nil if termbox_event.nil?
        
        case termbox_event.type
        when Termbox::EVENT_KEY
          if termbox_event.key != 0
            KeyDown.new( key: termbox_event.key )
          elsif termbox_event.character != 0
            KeyDown.new( character: termbox_event.character.chr )
          else
            nil
          end
        when Termbox::EVENT_RESIZE then Resize.new( width: termbox_event.width, height: termbox_event.height )
        end
      end
      
    end
    
  end
end
