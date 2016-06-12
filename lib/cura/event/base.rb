if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
  require "cura/attributes/has_events"
  require "cura/event"
end

module Cura
  module Event
    # The base class for all events.
    class Base
      class << self
        # Get the name of this class as a symbol.
        # For example, `SomeAction` would be `:some_action`.
        #
        # @return [Symbol]
        def name
          # Note: 1.3 times faster but relys on Regexp and is the only usage of regexp throughout cura.
          #       Using non regexp version until multiple usages of regexp occur within cura.
          # to_s.split(/::/).last.gsub(/([a-z])([A-Z])/, '\1_\2').downcase.to_sym

          # Note: MRuby does not have a #chars method so this is now 2.6 times slower instead of 1.3
          caps = ("A".."Z")
          index = 0
          to_s.split("::").last.split("").each_with_object("") do |char, memo|
            memo << "_" if index > 0 && caps.include?(char)
            memo << char
            index += 1
          end.downcase.to_sym
        end

        # Add the subclass to `Event.all`, when inherited.
        def inherited(subclass)
          Event.all << subclass
        end
      end # << self

      include Attributes::HasInitialize
      include Attributes::HasAttributes

      def initialize(attributes={})
        @created_at = Time.now

        super
      end

      # Get the time this event was created.
      #
      # @return [Time]
      attr_reader :created_at

      # Get the target this event was dispatched to.
      # TODO: Rename to source.
      #       The source is the component the event was originally sent to.
      #       The target is the component the event is currently being handled by. <- Needed?
      #
      # @return [Cura::Attributes::HasEvents]
      attr_reader :target

      # Set the target this event was dispatched to.
      #
      # @param [Cura::Attributes::HasEvents] value
      # @return [Cura::Attributes::HasEvents]
      def target=(value)
        raise TypeError, "target must be a Cura::Attributes::HasEvents" unless value.is_a?(Cura::Attributes::HasEvents) # TODO: Error::Event::InvalidTarget

        @target = value
      end

      # Get this event as a Hash.
      #
      # @return [Hash]
      def to_h
        { name: self.class.name }
      end

      # Check if something is equivalent to this event.
      #
      # @param [Object] other The object to check equivalence with.
      # @return [Boolean]
      def ==(other)
        # TODO: Below is needed?
        # object_equivalence = super
        # return true if object_equivalence

        other = other.to_h if other.respond_to?(:to_h)

        other == to_h
      end

      # Dispatches this event directly to it's target, if it has an application.
      #
      # @return [Event::Base] This event.
      def dispatch
        target.event_handler.handle(self)

        self
      end
    end
  end
end
