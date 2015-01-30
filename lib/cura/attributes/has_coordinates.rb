module Cura
  module Attributes
    
    # Adds the `x` and `y` attributes.
    module HasCoordinates
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        @x, @y = 0, 0
        
        super
      end
      
      # Get the X coordinate of this object.
      attr_reader :x
      
      # Set the X coordinate of this object.
      def x=(value)
        raise ArgumentError, 'x must respond to :to_i' unless value.respond_to?(:to_i)
        
        @x = value.to_i
      end
      
      # Get the Y coordinate of this object.
      attr_reader :y
      
      # Set the Y coordinate of this object.
      def y=(value)
        raise ArgumentError, 'y must respond to :to_i' unless value.respond_to?(:to_i)
        
        @y = value.to_i
      end
      
    end
    
  end
end
