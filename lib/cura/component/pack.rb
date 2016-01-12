if Kernel.respond_to?(:require)
  require "cura/attributes/has_orientation"
  require "cura/component/group"
end

module Cura
  module Component
    
    # A component with children which moves and optionally resizes them.
    # TODO: Expand attribute - See: http://www.pygtk.org/pygtk2tutorial/sec-DetailsOfBoxes.html
    # TODO: I think the only time it needs to pack_children is right before drawing? Would that get messy?
    class Pack < Group
      
      include Attributes::HasOrientation
      
      def initialize(attributes={})
        @fill = false
        @spacing = 0
        
        # @child_modifiers
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
      #
      # @param [Component] component
      # @param [#to_hash, #to_h] options
      # @option options [#to_i] :expand
      #   The new child is to be given extra space. The extra space will be divided evenly between all children that use this option.
      # @option options [#to_i] :fill
      #   The space given to child by the expand option is actually allocated to child, rather than just padding it.
      #   This parameter has no effect if expand is set to false.
      # @return [Component]
      def add_child(component)
        child = super

        pack_children

        child
      end

      # Remove a child from this object's children at the given index.
      #
      # @param [#to_i] index
      # @return [Component]
      def delete_child_at(index)
        child = super

        pack_children

        child
      end
      
      # Get whether children will be filled.
      # If this pack's orientation is set to :vertical, then the children's width will be set to this pack's width.
      # If this pack's orientation is set to :horizontal, then the children's height will be set to this pack's width.
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
        value = value.to_i
        value = 0 if value < 0
        
        @spacing = value
      end
      
      # Draw this pack.
      #
      # @return [Pack]
      def draw
        pack_children

        super
      end
      
      protected
      
      # Position and resize this pack's children based on it's attributes.
      def pack_children
        child_x = 0
        child_y = 0
        
        children.each do |child|
          if horizontal?
            child.x = child_x
            child_x += child.width + child.offsets.width + spacing
            
            child.height = height if fill?
          elsif vertical?
            child.y = child_y if vertical?
            child_y += child.height + child.offsets.height + spacing
            
            child.width = width if fill?
          end
        end
      end
      
    end
    
  end
end
