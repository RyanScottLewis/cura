if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"

  require "cura/error/invalid_color"

  require "cura/color"
end

module Cura
  module Attributes
    # Adds the #foreground and #background attributes.
    # TODO: Should be color and background... HasBackground and HasColor
    module HasColors
      include HasAttributes

      def initialize(attributes={})
        @foreground = :inherit unless instance_variable_defined?(:@foreground)
        @background = :inherit unless instance_variable_defined?(:@background)

        super
      end

      # @method foreground
      # Get the foreground color of this object.
      #
      # @return [Color]

      # @method foreground=(value)
      # Set the foreground color of this object.
      #
      # @param [Color, #to_sym] value
      # @return [Color]

      attribute(:foreground) { |value| validate_color_attribute(value) }

      # @method background
      # Get the background color of this object.
      #
      # @return [Color]

      # @method background=(value)
      # Set the background color of this object.
      #
      # @param [Color, #to_sym] value
      # @return [Color]

      attribute(:background) { |value| validate_color_attribute(value) }

      protected

      def validate_color_attribute(value)
        unless value.is_a?(Cura::Color)
          value = value.to_sym

          if [:black, :white, :red, :green, :blue].include?(value)
            value = Cura::Color.send(value)
          else
            raise Error::InvalidColor unless value == :inherit
          end
        end

        value
      end
    end
  end
end
