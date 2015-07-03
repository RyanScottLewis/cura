if Kernel.respond_to?(:require)
  require 'cura/component/base'
end

module Cura
  module Attributes
    
    # Allows an object to have child components.
    # TODO: Lots of code is the same as HasWindows
    module HasChildren
      
      include Enumerable
      
      def initialize(*arguments)
        @children = []
        
        super
      end
      
      # Traverse the children of this object.
      # 
      # @return [Array]
      def each(&block)
        @children.each(&block)
      end
      
      # Get the children of this object.
      # 
      # @return [<Component>]
      attr_reader :children
      
      # Add a child to this group.
      # 
      # @param [Component] component
      # @return [Component]
      def add_child(component)
        raise TypeError, 'component must be a Cura::Component' unless component.is_a?(Component::Base)
        
        @children << component
        
        component
      end
      
      # Add multiple children to this group.
      # 
      # @param [Component] component
      # @return [Component]
      def add_children(*children)
        children.each { |child| add_child(child) }
      end
      
      # Remove a child from this object's children at the given index.
      # 
      # @param [#to_i] index
      # @return [Component]
      def delete_child_at(index)
        @children.delete_at( index.to_i )
      end
      
      # Remove a child from this object's children.
      # 
      # @param [Component] component
      # @return [Component]
      def delete_child(component)
        raise TypeError, 'component must be a Cura::Component' unless component.is_a?(Component::Base)
        
        delete_child_at( @children.index(component) )
      end
      
      # Remove all children.
      def delete_children
        (0...@children.count).to_a.reverse.each { |index| delete_child_at(index) }
      end
      
      protected
      
      def update_children
        children.each(&:update)
      end
      
      def draw_children
        children.each(&:draw)
      end
      
    end
    
  end
end
