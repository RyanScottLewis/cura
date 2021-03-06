if Kernel.respond_to?(:require)
  require "cura/attributes/has_ancestry"
  require "cura/event/handler"
end

module Cura
  module Attributes
    # Adds an `event_handler` attribute as well as `callbacks` and `on_event` class methods.
    # When subclassed, the callbacks are inherited.
    # TODO: Rename to HasEventHandler
    module HasEvents
      # The class methods to be mixed in when included.
      module ClassMethods
        # The callbacks stored on this class.
        #
        # @return [Hash<Symbol,Array<Proc>>]
        def callbacks
          @callbacks ||= {}
        end

        # Store a callback on this class.
        # Stored callbacks will be registered on the event handler on initialization.
        #
        # @param [nil, #to_sym] event_name The event name.
        # @yield The callback block.
        # @return [Proc] The callback block.
        def on_event(event_name=:default, &block)
          (callbacks[event_name.to_sym] ||= []) << block

          block
        end

        # Register this classes callbacks onto the subclass, when inherited.
        def inherited(subclass)
          callbacks.each do |event_name, blocks|
            blocks.each do |block|
              subclass.on_event(event_name, &block)
            end
          end
        end
      end

      class << self
        def included(base)
          base.send(:extend, ClassMethods)
        end
      end

      def initialize(attributes={})
        @event_handler = Event::Handler.new(self)
        register_class_callbacks

        super
      end

      # Get the event handler for this object.
      #
      # @return [Event::Handler]
      attr_reader :event_handler # TODO: Rename to #events ?

      # Register a callback for an event to this instance.
      #
      # @param [nil, #to_sym] event_name The event name.
      # @yield The callback block.
      # @return [Proc] The callback block.
      def on_event(event_name=:default, *arguments, &block)
        event_handler.register(event_name, *arguments, &block)
      end

      protected

      def register_class_callbacks
        self.class.callbacks.each do |event_name, blocks|
          blocks.each do |block|
            @event_handler.register(event_name, &block)
          end
        end
      end
    end
  end
end
