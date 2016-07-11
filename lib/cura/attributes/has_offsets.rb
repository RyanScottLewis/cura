if Kernel.respond_to?(:require)
  require "cura/borders"
  require "cura/margins"
  require "cura/offsets"
  require "cura/padding"
  
  require "cura/helpers/conversions"

  require "cura/attributes/has_attributes"
end

module Cura
  module Attributes
    # Adds the `offsets` attribute to objects.
    module HasOffsets
      include Helpers::Conversions
      include HasAttributes

      def initialize(attributes={})
        @offsets = Offsets.new(component: self)

        self.margin  = attributes[:margin]
        self.border  = attributes[:border]
        self.padding = attributes[:padding]

        super
      end

      # Get the borders of this object.
      #
      # @return [Borders]
      attr_reader :border

      # Set the borders of this object.
      #
      # @param [Borders, #to_h] value
      # @return [Borders]
      def border=(value)
        @border = convert_instance(value, Borders)
      end

      # Get the margins of this object.
      #
      # @return [Margins]
      attr_reader :margin

      # Set the margins of this object.
      #
      # @param [Margins, #to_h] value
      # @return [Margins]
      def margin=(value)
        @margin = convert_instance(value, Margins)
      end

      # Get the padding of this object.
      #
      # @return [Padding]
      attr_reader :padding

      # Set the padding of this object.
      #
      # @param [Padding, #to_h] value
      # @return [Padding]
      def padding=(value)
        @padding = convert_instance(value, Padding)
      end

      # Get the offsets of this object.
      #
      # @return [Offsets]
      attr_reader :offsets
    end
  end
end
