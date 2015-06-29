if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/attributes/has_object_attributes'
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
      include HasObjectAttributes
      
      # @method borders
      # Get the borders of this object.
      # 
      # @return [Borders]
      
      # @method borders=(value)
      # Set the borders of this object.
      # 
      # @param [Borders, #to_hash, #to_h] value
      # @return [Borders]
      attr_object :borders, Borders
      
      # @method margins
      # Get the margins of this object.
      # 
      # @return [Margins]
      
      # @method margins=(value)
      # Set the margins of this object.
      # 
      # @param [Margins, #to_hash, #to_h] value
      # @return [Margins]
      attr_object :margins, Margins
      
      # @method padding
      # Get the padding of this object.
      # 
      # @return [Padding]
      
      # @method padding=(value)
      # Set the padding of this object.
      # 
      # @param [Padding, #to_hash, #to_h] value
      # @return [Padding]
      attr_object :padding, Padding
      
      def initialize(attributes={})
        @offsets = Offsets.new( component: self )
        
        self.margins = attributes[:margins]
        self.borders = attributes[:borders]
        self.padding = attributes[:padding]
        
        super
      end
      
      # Get the offsets of this object.
      # 
      # @return [Offsets]
      attr_reader :offsets
      
    end
    
  end
end
