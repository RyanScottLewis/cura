if Kernel.respond_to?(:require)
  require "cura/attributes/has_ancestry"
  require "cura/attributes/has_coordinates"
end

module Cura
  module Attributes
    
    # Adds the `absolute_x` and `absolute_y` attributes, which are relative to it's parent.
    module HasRelativeCoordinates
      
      include HasAncestry
      include HasCoordinates
      
      def initialize(attributes={})
        @absolute_x = 0
        @absolute_y = 0
        
        super
      end
      
      # Get the absolute X coordinate of this object.
      #
      # @return [Integer]
      def absolute_x
        parent? && parent.respond_to?(:absolute_x) ? @x + parent.offsets.left + parent.padding.left + parent.absolute_x : @x
      end
      
      # Get the absolute Y coordinate of this object.
      #
      # @return [Integer]
      def absolute_y
        parent? && parent.respond_to?(:absolute_y) ? @y + parent.offsets.top + parent.padding.top + parent.absolute_y : @y
      end
      
    end
    
  end
end
