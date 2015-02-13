module Cura
  module Component
    
    # A Group which moves and optionally resizes children.
    # TODO: Expand attribute - See: http://www.pygtk.org/pygtk2tutorial/sec-DetailsOfBoxes.html
    # TODO: I think the only time it needs to pack_children is right before drawing? Would that get messy?
    class Pack < Group
      
      include Attributes::HasOrientation
      
      def initialize(attributes={})
        @fill, @spacing = false, 0
        
        super
      end
      
      # Set the width dimension of this pack.
      def width=(value)
        result = super
    
        pack_children
    
        result
      end
      
      # Set the height dimension of this pack.
      def height=(value)
        result = super
    
        pack_children
    
        result
      end
      
      # Add a child to this group.
      # TODO: Pass fill/expand options
      def add_child(component)
        child = super
    
        pack_children
    
        child
      end
      
      # Remove a child from this object's children at the given index.
      def delete_child_at(index)
        child = super
    
        pack_children
    
        child
      end
      
      # Get whether children will be filled.
      # 
      # @return [Boolean]
      def fill?
        @fill
      end
      
      # Set whether children will be filled.
      # Must be truthy or falsey.
      # 
      # If set to a truthy value, children will be resized to fit the space available to it.
      # For example, if orientation is set to :horizontal, then all of the children's width attributes
      # will be set to this instance's width.
      # 
      # @param [Object] value
      # @return [Boolean]
      def fill=(value)
        @fill = !!value
    
        pack_children
    
        @fill
      end
      
      # Get the spacing between children.
      # 
      # @return [Integer]
      attr_reader :spacing
      
      # Set the spacing between children.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def spacing=(value)
        raise TypeError, 'spacing must respond to #to_i' unless value.respond_to?(:to_i)
        
        value = value.to_i
        value = 0 if value < 0
        
        @spacing = value
    
        pack_children
    
        @spacing
      end
      
      # Draw this pack.
      def draw
        pack_children
        
        super
      end
      
      protected
      
      # Position and resize this pack's children based on it's attributes.
      def pack_children
        child_x, child_y = 0, 0
        
        children.each do |child|
          if horizontal?
            child.x = child_x
            child.height = height if fill?
            child_x += child.outer_width + spacing
          elsif vertical?
            child.y = child_y if vertical?
            child.width = width if fill?
            child_y += child.outer_height + spacing
          end
        end
      end
      
    end
    
  end
end
