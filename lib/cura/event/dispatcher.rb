if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_attributes'
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_events'
  require 'cura/event/base'
end

module Cura
  module Event
    
    # Polls or peeks for events since the last execution and dispatches them to the appropriate component.
    class Dispatcher
      
      include Attributes::HasInitialize
      include Attributes::HasAttributes
      include Attributes::HasApplication
      
      def initialize(attributes={})
        super
        
        raise ArgumentError, 'application must be set' if @application.nil?
        @target = @application if @target.nil?
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
        raise TypeError, 'target must be a Cura::Attributes::HasEvents' unless value.is_a?(Attributes::HasEvents)
        
        @target = value
      end
      
      # Wait forever for an event and handle it.
      # 
      # @return [Event::Base] The event
      def poll
        event = @application.adapter.poll_event
        
        dispatch_event(event)
      end
      
      # Wait a set amount of time for an event and handle it if needed.
      # 
      # @param [#to_i] milliseconds The amount of time to wait in milliseconds.
      # @return [nil, Event::Base] The event, if handled.
      def peek(milliseconds=100)
        event = @application.adapter.peek_event( milliseconds.to_i )
        
        dispatch_event(event) unless event.nil?
      end
      
      # Dispatch an event to the target or application, if the target is nil.
      # 
      # @param [Event::Base] event
      # @return [Event::Base] The event.
      def dispatch_event(event)
        raise TypeError, 'event must be an Event::Base' unless event.is_a?(Event::Base)
        
        event.target = @target
        @target.event_handler.handle(event)
        
        event
      end
      
    end
    
  end
end
