if Kernel.respond_to?(:require)
  require 'cura/attributes/has_ancestry'
  require 'cura/attributes/has_coordinates'
end

module Cura
  module Attributes
    
    # Adds the `absolute_x` and `absolute_y` attributes, which are relative to it's parent.
    module HasRelativeCoordinates
      
      include HasAncestry
      include HasCoordinates
      
      def initialize(attributes={})
        @absolute_x, @absolute_y = 0, 0
        
        super
      end
      
      # Get the absolute X coordinate of this object.
      # 
      # @return [Integer]
      def absolute_x
        parent? && parent.respond_to?(:absolute_x) ? parent.absolute_x + @x : @x # ancestors.collect(&:x).inject(&:+)
      end
      
      # Get the absolute Y coordinate of this object.
      # 
      # @return [Integer]
      def absolute_y
        parent? && parent.respond_to?(:absolute_y) ? parent.absolute_y + @y : @y # ancestors.collect(&:y).inject(&:+)
      end
      
    end
    
  end
end
