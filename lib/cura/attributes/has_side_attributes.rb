if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
end

module Cura
  module Attributes
    
    # Adds the `top`, `right`, `bottom`, `left`, `width`, and `height` attributes to objects.
    module HasSideAttributes
      
      include HasAttributes
      
      # @method top
      # Get the top attribute.
      #
      # @return [Integer]
      
      # @method top=(value)
      # Set the top attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      
      attribute(:top) { |value| validate_size_attribute(value) }
      
      # @method right
      # Get the right attribute.
      #
      # @return [Integer]
      
      # @method right=(value)
      # Set the right attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      
      attribute(:right) { |value| validate_size_attribute(value) }
      
      # @method bottom
      # Get the bottom attribute.
      #
      # @return [Integer]
      
      # @method bottom=(value)
      # Set the bottom attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      
      attribute(:bottom) { |value| validate_size_attribute(value) }
      
      # @method left
      # Get the left attribute.
      #
      # @return [Integer]
      
      # @method left=(value)
      # Set the left attribute.
      #
      # @param [#to_i] value
      # @return [Integer]
      
      attribute(:left) { |value| validate_size_attribute(value) }
      
      def initialize(attributes={})
        @top = 0 unless instance_variable_defined?(:@top)
        @right = 0 unless instance_variable_defined?(:@right)
        @bottom = 0 unless instance_variable_defined?(:@bottom)
        @left = 0 unless instance_variable_defined?(:@left)
        
        unless attributes.respond_to?(:to_hash) || attributes.respond_to?(:to_h)
          attributes = { top: attributes, right: attributes, bottom: attributes, left: attributes }
        end
        
        super
      end
      
      # Get the total height of the attributes.
      #
      # @return [Integer]
      def height
        @top + @bottom
      end
      
      # Get the total width of the attributes.
      #
      # @return [Integer]
      def width
        @left + @right
      end
      
    end
    
  end
end
