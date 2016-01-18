require "cura/event/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    # Dispatched when a key's state changes from up to down.
    class KeyDown < Base
      def initialize(attributes={})
        @control = false

        super

        raise ArgumentError, "name must be set" if @name.nil?
      end

      # Get whether the key was pressed while holding the control key.
      #
      # @return [Boolean]
      def control?
        @control
      end

      # Get the key name.
      #
      # @return [Integer]
      attr_reader :name

      # Get whether the key is printable.
      #
      # @return [Boolean]
      def printable?
        return false if @control

        Key.name_is_printable?(@name)
      end

      # Get the printable character for the key.
      #
      # @return [nil, String]
      def character
        Key.character_from_name(@name)
      end

      protected

      # Set if the key was pressed while holding the control key.
      #
      # @param [Boolean] value
      # @return [Boolean]
      def control=(value)
        @control = !!value
      end

      # Set the key name.
      #
      # @param [#to_sym] value
      # @return [String]
      def name=(value)
        @name = value.to_sym
      end
    end
  end
end
