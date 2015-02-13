module Cura
  module Attributes
    
    # Adds the `orientation` attribute to objects, which can be :vertical or :horizontal.
    module HasOrientation
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        @orientation = :vertical
        
        super
      end
      
      # Get the orientation of this object.
      attr_reader :orientation
      
      # Set the orientation of this object.
      # Must be :vertical or :horizontal.
      def orientation=(value)
        raise TypeError, 'orientation must respond to :to_sym' unless value.respond_to?(:to_sym)
        value = value.to_sym
        raise ArgumentError, 'orientation must be one of :vertical or :horizontal' unless [:vertical, :horizontal].include?(value)
        
        @orientation = value
      end
      
      # Check if this object's orientation is set to :horizontal.
      def horizontal?
        orientation == :horizontal
      end
      
      # Check if this object's orientation is set to :vertical.
      def vertical?
        orientation == :vertical
      end
      
    end
    
  end
end
