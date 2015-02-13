if Kernel.respond_to?(:require)
  require 'cura/attributes/has_ancestry'
  require 'cura/attributes/has_coordinates'
end

module Cura
  module Attributes
    
    # Adds the `absolute_x` and `absolute_y` attributes, which are relative to it's parent.
    module HasRelativeCoordinates
      
      include Attributes::HasAncestry
      include Attributes::HasCoordinates
      
      def initialize(attributes={})
        @absolute_x, @absolute_y = 0, 0
        
        super
      end
      
      # Get the absolute X coordinate of this object.
      # 
      # @return [Integer]
      def absolute_x
        ancestors.collect(&:x).inject(&:+)
      end
      
      # Get the absolute Y coordinate of this object.
      # 
      # @return [Integer]
      def absolute_y
        ancestors.collect(&:y).inject(&:+)
      end
      
    end
    
  end
end
