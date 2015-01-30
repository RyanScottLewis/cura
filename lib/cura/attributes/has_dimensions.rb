module Cura
  module Attributes
    
    # Adds the `width` and `height` attributes.
    module HasDimensions
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        @width, @height = 0, 0
        
        super
      end
      
      # Get the width dimension of this object.
      attr_reader :width
      
      # Set the width dimension of this object.
      def width=(value)
        raise ArgumentError, 'width must respond to :to_i' unless value.respond_to?(:to_i)
        
        value = value.to_i
        value = 0 if value < 0
        
        @width = value
      end
      
      # Get the height dimension of this object.
      attr_reader :height
      
      # Set the height dimension of this object.
      def height=(value)
        raise ArgumentError, 'height must respond to :to_i' unless value.respond_to?(:to_i)
        
        value = value.to_i
        value = 0 if value < 0
        
        @height = value
      end
      
    end
    
  end
end
