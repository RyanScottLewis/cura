if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
  require "cura/attributes/has_application"
  require "cura/attributes/has_events"
  require "cura/event/base"
  require "cura/error/invalid_middleware"
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

        raise ArgumentError, "application must be set" if @application.nil?

        @wait_time = 100
        @target = @application if @target.nil?
        @middleware = []
      end

      # @method wait_time
      # Get the time to wait for events in milliseconds in the run loop.
      #
      # @return [Integer]

      # @method wait_time=(value)
      # Set the time to wait for events in milliseconds in the run loop.
      # Set to 0 to wait forever (poll instead of peek).
      #
      # @param [#to_i] value
      # @return [Integer]

      attribute(:wait_time) do |value|
        value = value.to_i
        value = 0 if value < 0

        value
      end

      # @method target
      # Get the object with an event handler to dispatch events to.
      #
      # @return [Cura::Attributes::HasEvents]
      attr_reader :target # TODO: use .attribute() { |value| ... }

      # @method target=(value)
      # Set the object with an event handler to dispatch events to.
      # Setting to nil will automatially set the target to the application.
      #
      # @param [nil, Cura::Attributes::HasEvents] value
      # @return [Cura::Attributes::HasEvents]
      def target=(value)
        raise TypeError, "target must be a Cura::Attributes::HasEvents or nil" unless value.nil? || value.is_a?(Attributes::HasEvents)

        dispatch_event(:unfocus)
        @target = value.nil? ? @application : value
        dispatch_event(:focus)

        value
      end

      # The middleware stack which an event will pass through before being dispatched.
      # Middleware must be an object responding to #call.
      #
      # @return [Array]
      attr_reader :middleware

      # Poll or peek for events and dispatch it if one was found.
      #
      # @return [Event::Dispatcher]
      def run
        event = @wait_time == 0 ? poll : peek(@wait_time)

        dispatch_event(event) unless event.nil?
      end

      # Wait forever for an event.
      #
      # @return [Event::Base]
      def poll
        @application.adapter.poll_event
      end

      # Wait a set amount of time for an event.
      #
      # @param [#to_i] milliseconds The amount of time to wait in milliseconds.
      # @return [nil, Event::Base] The event, if handled.
      def peek(milliseconds=100)
        @application.adapter.peek_event(milliseconds.to_i)
      end

      # Send the event through the middleware stack and dispatch all events on the queue.
      #
      # @param [#to_sym] event The name of the event class to create an instance of or an event instance.
      # @param [#to_hash, #to_h] options The options to pass through the middleware.
      # @return [Event::Base] The dispatched event.
      def dispatch_event(event, options={})
        event = Event.new_from_name(event, options) if event.respond_to?(:to_sym)
        raise TypeError, "event must be an Event::Base" unless event.is_a?(Event::Base)

        options = { dispatcher: self, event: event, dispatch_queue: [] }.merge(options.to_h)

        @middleware.each { |middleware| middleware.call(options) }

        options[:dispatch_queue].each(&:dispatch)
      end
    end
  end
end
