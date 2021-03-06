if Kernel.respond_to?(:require)
  require "cura/helpers/validations"
  require "cura/attributes/has_attributes"
end

module Cura
  module Attributes
    # Adds the `width` and `height` attributes.
    module HasDimensions
      include Helpers::Validations
      include HasAttributes

      def initialize(attributes={})
        @width = :auto unless instance_variable_defined?(:@width)
        @height = :auto unless instance_variable_defined?(:@height)

        super
      end

      # Get the width dimension of this object.
      #
      # @return [Integer]
      attr_reader :width

      # Set the width dimension of this object.
      #
      # @param [#to_i] value
      # @return [Integer]
      def width=(value)
        @width = validate_size_attribute(value)
      end

      # Get the height dimension of this object.
      #
      # @return [Integer]
      attr_reader :height

      # Set the height dimension of this object.
      #
      # @param [#to_i] value
      # @return [Integer]
      def height=(value)
        @height = validate_size_attribute(value)
      end

      # Set one or both of the dimensions of this object.
      # @param [#to_h] options
      # @option options [#to_i] :width
      # @option options [#to_i] :height
      # @return [Object] This object
      def resize(options)
        options = options.to_h

        self.width = options[:width] if options.key?(:width)
        self.height = options[:height] if options.key?(:height)

        self
      end
    end
  end
end
