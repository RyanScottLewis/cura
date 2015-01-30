module Cura
  module Event
    
    # The event handler.
    # 
    # Initialze with an object who's class responds to #callbacks, such as a GUI::HasEvents object.
    # All events delegate from an object to it's parent all the way up to the root (application).
    class Handler
      
      # @param [.callbacks] host The object this handler is attached to.
      def initialize(host)
        raise TypeError, "host's class must respond to #callbacks" unless host.class.respond_to?(:callbacks)
        
        @host, @callbacks = host, { __default__: [] }
        
        host.class.callbacks.each do |event_name, callbacks|
          callbacks.each { |callback| register( event_name, &callback ) }
        end
      end
      
      # Get the object this handler is attached to.
      # 
      # @return [Object]
      attr_reader :host
      
      # The callbacks defined on this handler.
      # 
      # @return [Hash<Symbol,Array>]
      attr_reader :callbacks
      
      # Add a callback to the event chain.
      # The first registered callback is the first called (FIFO).
      # If no event_name is given, the callback is registered to the :__default__ name, which are called before all others.
      def register(event_name=:__default__, &callback)
        ( @callbacks[event_name] ||= [] ) << callback
      end
      
      # Run all callbacks registered on this instance for the given event.
      # The event object is given as a block argument to the callbacks.
      # TODO: These should be able to break the callback chain by returning false in the callback (which would also break the delegation chain).
      # TODO: The event should be delegated to the host's #parent if there are no callbacks registered for it, if it responds to #parent, and it's not nil.
      def handle(event)
        callbacks = @callbacks[:__default__] + @callbacks[ event.name ].to_a
        
        chain_broken = false
        callbacks.each do |callback|
          
          result = host.instance_exec( event, &callback )
          
          if result == false
            chain_broken = true
            break
          end
          
        end
        
        delegate_event(event) unless chain_broken
      end
      
      protected
      
      # Delegate the event to the host's applicable #parent or #application.
      def delegate_event(event)
        host.parent.event_handler.handle(event) if host.respond_to?(:parent) && host.parent.respond_to?(:event_handler)
      end
      
    end
    
  end
end
