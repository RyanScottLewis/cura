if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/borders'
  require 'cura/margins'
  require 'cura/padding'
  require 'cura/offsets'
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
      # @param [Borders, #to_hash, #to_h] value
      # @return [Borders]
      
      attribute(:border, type: Borders) { |value, options| validate_offset_attribute(value, options) }
      
      # @method margin
      # Get the margins of this object.
      # 
      # @return [Margins]
      
      # @method margin=(value)
      # Set the margins of this object.
      # 
      # @param [Margins, #to_hash, #to_h] value
      # @return [Margins]
      
      attribute(:margin, type: Margins) { |value, options| validate_offset_attribute(value, options) }
      
      # @method padding
      # Get the padding of this object.
      # 
      # @return [Padding]
      
      # @method padding=(value)
      # Set the padding of this object.
      # 
      # @param [Padding, #to_hash, #to_h] value
      # @return [Padding]
      
      attribute(:padding, type: Padding) { |value, options| validate_offset_attribute(value, options) }
      
      def initialize(attributes={})
        @offsets = Offsets.new( component: self )
        
        self.margin = attributes[:margin]
        self.border = attributes[:border]
        self.padding = attributes[:padding]
        
        super
      end
      
      # Get the offsets of this object.
      # 
      # @return [Offsets]
      attr_reader :offsets
      
      protected
      
      def validate_offset_attribute(value, options={})
        value ||= {}
        
        result = value.is_a?( options[:type] ) ? value : options[:type].new(value)
      end
      
    end
    
  end
end
