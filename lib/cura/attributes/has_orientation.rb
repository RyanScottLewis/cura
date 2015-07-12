if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"
end

module Cura
  module Attributes
    
    # Adds the `orientation` attribute to objects, which can be :vertical or :horizontal.
    module HasOrientation
      
      include HasAttributes
      
      def initialize(attributes={})
        @orientation = :vertical unless instance_variable_defined?(:@orientation)
        
        super
      end
      
      # Get the orientation of this object.
      # 
      # @return [Symbol]
      attr_reader :orientation
      
      # Set the orientation of this object.
      # Must be :vertical or :horizontal.
      # 
      # @param [#to_sym] value
      # @return [Symbol]
      def orientation=(value)
        value = value.to_sym
        raise ArgumentError, "orientation must be one of :vertical or :horizontal" unless [:vertical, :horizontal].include?(value)
        
        @orientation = value
      end
      
      # Check if this object's orientation is set to :horizontal.
      # 
      # @return [Boolean]
      def horizontal?
        orientation == :horizontal
      end
      
      # Check if this object's orientation is set to :vertical.
      # 
      # @return [Boolean]
      def vertical?
        orientation == :vertical
      end
      
    end
    
  end
end
