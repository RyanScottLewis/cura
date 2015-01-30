module Cura
  module Attributes
    
    # Adds an `event_handler` attribute.
    module HasEvents
      
      module ClassMethods
        
        # The callbacks registered to this class.
        # 
        # @return [Hash<Symbol,Array<Proc>>]
        def callbacks
          @callbacks ||= {}
        end
        
        # Register a callback for an event to this class.
        # 
        # @return [Proc] The callback block.
        def on_event(event_name=:__default__, &block)
          raise TypeError, 'event_name must be nil or respond to #to_sym' unless event_name.nil? || event_name.respond_to?(:to_sym)
          
          ( callbacks[ event_name.to_sym ] ||= [] ) << block
          
          block
        end
        
        # Register this classes callbacks onto the subclass, when inherited.
        def inherited(subclass)
          callbacks.each do |event_name, callbacks|
            callbacks.each { |callback| subclass.on_event(event_name, &callback) }
          end
        end
        
      end
      
      def self.included(base)
        base.send( :extend, ClassMethods )
      end
      
      def initialize(*args)
        @event_handler = Event::Handler.new(self)
        
        super
      end
      
      # Get the event handler for this widget.
      # 
      # @return [Event::Handler]
      attr_reader :event_handler
      
      # Register a callback for an event to this instance.
      # 
      # @return [Proc] The callback block.
      def on_event(event_name=:__default__, &block)
        event_handler.register( event_name, &block )
      end
      
    end
    
  end
end
