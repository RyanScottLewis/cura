require "cura/attributes/has_attributes" if Kernel.respond_to?(:require)

module Cura
  module Attributes
    # Adds the `width` and `height` attributes.
    module HasDimensions
      include HasAttributes

      def initialize(attributes={})
        @width = :auto unless instance_variable_defined?(:@width)
        @height = :auto unless instance_variable_defined?(:@height)

        super
      end

      # @method width
      # Get the width dimension of this object.
      #
      # @param [#to_i] value
      # @return [Integer]

      # @method width=(value)
      # Set the width dimension of this object.
      #
      # @return [Integer]

      attribute(:width) { |value| validate_size_attribute(value) }

      # @method height
      # Get the height dimension of this object.
      #
      # @return [Integer]

      # @method height=(value)
      # Set the height dimension of this object.
      #
      # @param [#to_i] value
      # @return [Integer]

      attribute(:height) { |value| validate_size_attribute(value) }

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
