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

      # @method x
      # Get the X coordinate of this object.
      #
      # @return [Integer]

      # @method x=(value)
      # Set the X coordinate of this object.
      #
      # @param [#to_i] value
      # @return [Integer]

      attribute(:x) { |value| value.to_i }

      # @method y
      # Get the Y coordinate of this object.
      #
      # @return [Integer]

      # @method y=(value)
      # Set the Y coordinate of this object.
      #
      # @param [#to_i] value
      # @return [Integer]

      attribute(:y) { |value| value.to_i }
    end
  end
end
