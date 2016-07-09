if Kernel.respond_to?(:require)
  require "cura/helpers/validations"
  require "cura/attributes/has_attributes"
end

module Cura
  module Attributes
    # Adds the `top`, `right`, `bottom`, `left`, `width`, and `height` attributes to objects.
    module HasSideAttributes
      include Helpers::Validations
      include HasAttributes

      def initialize(attributes={})
        @top    = 0 unless instance_variable_defined?(:@top)
        @right  = 0 unless instance_variable_defined?(:@right)
        @bottom = 0 unless instance_variable_defined?(:@bottom)
        @left   = 0 unless instance_variable_defined?(:@left)

        # Set all side attributes to the argument given unless it is Hash-like.
        unless attributes.respond_to?(:to_hash) || attributes.respond_to?(:to_h)
          attributes = { top: attributes, right: attributes, bottom: attributes, left: attributes }
        end

        super
      end

      # Get the top attribute.
      #
      # @return [Integer]
      attr_reader :top

      # Set the top attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      def top=(value)
        @top = validate_size_attribute(value)
      end

      # Get the right attribute.
      #
      # @return [Integer]
      attr_reader :right

      # Set the right attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      def right=(value)
        @right = validate_size_attribute(value)
      end

      # Get the bottom attribute.
      #
      # @return [Integer]
      attr_reader :bottom

      # Set the bottom attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      def bottom=(value)
        @bottom = validate_size_attribute(value)
      end

      # Get the left attribute.
      #
      # @return [Integer]
      attr_reader :left

      # Set the left attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      def left=(value)
        @left = validate_size_attribute(value)
      end

      # Get the total height of the attributes.
      #
      # @return [Integer]
      def height
        @top + @bottom
      end

      # Get the total width of the attributes.
      #
      # @return [Integer]
      def width
        @left + @right
      end
    end
  end
end
