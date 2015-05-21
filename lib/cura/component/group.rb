if Kernel.respond_to?(:require)
  require 'cura/attributes/has_children'
  require 'cura/component/base'
end

module Cura
  module Component
    
    class Group < Base
      
      include Attributes::HasChildren
      
      # Get the width of this group.
      # 
      # @return [Integer]
      def width
        value = super
        
        return value unless value == 0 # TODO: :auto option?
        return 0 if children.empty?
        
        children.collect { |child| child.x + child.width }.max
      end
      
      # Get the height of this group.
      # 
      # @return [Integer]
      def height
        value = super
        
        return value unless value == 0 # TODO: :auto option?
        return 0 if children.empty?
        
        children.collect { |child| child.y + child.height }.max
      end
      
      # Add a child to this group.
      # 
      # @param [Component] component
      # @return [Component]
      def add_child(component)
        component = super
        
        component.parent = self
        
        component
      end
      
      # Remove a child from this object's children at the given index.
      # 
      # @param [Integer] index
      # @return [Component]
      def delete_child_at(index)
        component = super
        
        component.parent = nil
        
        component
      end
      
      # Update all children.
      def update
        update_children
      end
      
      # Draw all children relative to this location.
      # TODO: If the dimensions of this group of this group are less than the computed dimensions, the drawing will be clipped.
      def draw
        super
        
        draw_children
      end
      
    end
    
  end
end
