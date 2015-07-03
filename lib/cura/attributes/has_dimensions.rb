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
      
      # @method width
      # Get the width dimension of this object.
      # 
      # @param [#to_i] value
      # @return [Integer]
      
      # @method width=(value)
      # Set the width dimension of this object.
      # 
      # @return [Integer]
      
      attribute(:width) { |value| validate_dimension_attribute(value) }
      
      # @method height
      # Get the height dimension of this object.
      # 
      # @return [Integer]
      
      # @method height=(value)
      # Set the height dimension of this object.
      # 
      # @param [#to_i] value
      # @return [Integer]
      
      attribute(:height) { |value| validate_dimension_attribute(value) }
      
      protected
      
      def validate_dimension_attribute(value)
        if value.is_a?(Symbol)
          valid_symbols = [ :auto, :inherit ]
          raise TypeError, "must be one of #{ valid_symbols.join(', ') }" unless valid_symbols.include?(value)
        else
          value = value.to_i
          value = 0 if value < 0
        end
        
        value
      end
      
    end
    
  end
end
