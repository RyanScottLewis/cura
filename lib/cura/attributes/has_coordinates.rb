require "cura/attributes/has_attributes" if Kernel.respond_to?(:require)

module Cura
  module Attributes
    # Adds the `x` and `y` attributes.
    module HasCoordinates
      include HasAttributes

      def initialize(attributes={})
        @x = 0 unless instance_variable_defined?(:@x)
        @y = 0 unless instance_variable_defined?(:@y)

        super
      end

      # Get the X coordinate of this object.
      #
      # @return [Integer]
      attr_reader :x

      # Set the X coordinate of this object.
      #
      # @param [#to_i] value
      # @return [Integer]
      def x=(value)
        @x = value.to_i
      end

      # Get the Y coordinate of this object.
      #
      # @return [Integer]
      attr_reader :y

      # Set the Y coordinate of this object.
      #
      # @param [#to_i] value
      # @return [Integer]
      def y=(value)
        @y = value.to_i
      end
    end
  end
end
