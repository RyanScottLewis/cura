if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"
  require "cura/borders"
  require "cura/margins"
  require "cura/padding"
  require "cura/offsets"
end

module Cura
  module Attributes
    
    # Adds the `offsets` attribute to objects.
    module HasOffsets
      
      include HasAttributes
      
      # @method border
      # Get the borders of this object.
      #
      # @return [Borders]
      
      # @method border=(value)
      # Set the borders of this object.
      #
      # @param [Borders, #to_h] value
      # @return [Borders]
      
      attribute(:border, type: Borders) { |value, options| validate_offset_attribute(value, options[:type]) }
      
      # @method margin
      # Get the margins of this object.
      #
      # @return [Margins]
      
      # @method margin=(value)
      # Set the margins of this object.
      #
      # @param [Margins, #to_h] value
      # @return [Margins]
      
      attribute(:margin, type: Margins) { |value, options| validate_offset_attribute(value, options[:type]) }
      
      # @method padding
      # Get the padding of this object.
      #
      # @return [Padding]
      
      # @method padding=(value)
      # Set the padding of this object.
      #
      # @param [Padding, #to_h] value
      # @return [Padding]
      
      attribute(:padding, type: Padding) { |value, options| validate_offset_attribute(value, options[:type]) }
      
      def initialize(attributes={})
        @offsets = Offsets.new(component: self)
        
        self.margin  = attributes[:margin]
        self.border  = attributes[:border]
        self.padding = attributes[:padding]
        
        super
      end
      
      # Get the offsets of this object.
      #
      # @return [Offsets]
      attr_reader :offsets
      
      protected
      
      def validate_offset_attribute(value, type)
        value ||= {}
        
        value.is_a?(type) ? value : type.new(value)
      end
      
    end
    
  end
end
