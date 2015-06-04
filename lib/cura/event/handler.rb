if Kernel.respond_to?(:require)
  require 'cura/attributes/has_events'
end

module Cura
  module Event
    
    # The event handler.
    # Each {Cura::Component} as well as several other class's instances have an instance of this handler. 
    # The handler can have multiple callbacks defined for an arbitrary event name.
    class Handler
      
      # @param [Cura::Attributes::HasEvents] host The object this handler is attached to.
      def initialize(host)
        raise TypeError, 'host must be a Cura::Attributes::HasEvents' unless host.is_a?(Cura::Attributes::HasEvents)
        
        @host, @callbacks = host, { default: [] }
      end
      
      # Get the object this handler is attached to.
      # 
      # @return [Object]
      attr_reader :host
      
      # The callbacks defined on this handler.
      # Key is the event name and the value is an Array of Proc instances.
      # 
      # @return [Hash<Symbol,Array>]
      attr_reader :callbacks
      
      # Add a callback to the event chain.
      # The first registered callback will be the first one called (FIFO).
      # If no event_name is given, the callback is registered to the `:default` name, which are called before all others.
      def register(event_name=:default, &callback)
        ( @callbacks[event_name] ||= [] ) << callback
      end
      
      # Run all callbacks registered on this instance for the given event.
      # The event object is given as a block argument to the callbacks.
      # TODO: These should be able to break the callback chain by returning false in the callback (which would also break the delegation chain).
      # TODO: The event should be delegated to the host's #parent if there are no callbacks registered for it, if it responds to #parent, and it's not nil.
      def handle(event)
        callbacks = @callbacks[:default] + @callbacks[ event.name ].to_a
        
        chain_broken = false
        callbacks.each do |callback|
          
          result = host.instance_exec( event, &callback )
          
          # TODO: Optional event consumption
          if result == false
            # chain_broken = true # TODO TODO TODO TODO TODO 
            
            break
          end
          
        end
        
        delegate_event(event) unless chain_broken
      end
      
      protected
      
      # Propagate the event to the host's applicable #parent or #application.
      # TODO: Why is the handler responsible for propagation? Should the component or a Event::Propagator be responsible?
      def delegate_event(event)
        host.parent.event_handler.handle(event) if host.respond_to?(:parent) && host.parent.respond_to?(:event_handler)
      end
      
    end
    
  end
end
