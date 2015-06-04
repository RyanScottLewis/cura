if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
end

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
      
      # Get the width dimension of this object.
      # 
      # @param [#to_i] value
      # @return [Integer]
      attr_reader :width
      
      # Set the width dimension of this object.
      # 
      # @return [Integer]
      def width=(value)
        value = value.to_i
        value = :auto if value < 0
        
        @width = value
      end
      
      # Get the height dimension of this object.
      # 
      # @return [Integer]
      attr_reader :height
      
      # Set the height dimension of this object.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def height=(value)
        value = value.to_i
        value = :auto if value < 0
        
        @height = value
      end
      
    end
    
  end
end
