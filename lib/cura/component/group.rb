if Kernel.respond_to?(:require)
  require "cura/attributes/has_children"
  require "cura/component/base"
end

module Cura
  module Component
    # A component with children.
    # When children are added, their parent will be set to this group.
    class Group < Base
      include Attributes::HasChildren

      # Get the width of this group.
      #
      # @return [Integer]
      def width
        return @width unless @width == :auto
        return 0 if children.empty?

        children.collect { |child| child.x + child.width + child.offsets.width }.max
      end

      # Get the height of this group.
      #
      # @return [Integer]
      def height
        return @height unless @height == :auto
        return 0 if children.empty?

        children.collect { |child| child.y + child.height + child.offsets.height }.max
      end

      # # Set the parent of this object.
      # # It's not recommended to set this directly as it may break the ancestory chain.
      # #
      # # @param [Object] value
      # # @return [Object]
      # def parent=(value)
      #   @parent = value
      #   @children.each
      #
      #   @parent
      # end

      # Add a child to this group and set it's parent to this Group.
      #
      # @param [#to_sym, Component] component_or_type
      #   A Symbol representing the child component type or a {Component::Base} instance.
      #   When a Symbol is given, a new child component will be initialized of that type. See {Component::Base.type}.
      # @param [#to_h] attributes
      #   When component_or_type is a Symbol, then these attributes will be used to initialize the child component.
      #   When component_or_type is a {Component::Base}, then these attributes will be used to update the child component.
      # @return [Component]
      def add_child(component_or_type, attributes={})
        component = super

        component.parent = self

        component
      end

      # Remove a child from this object's children at the given index and set it's parent to nil.
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
        super

        update_children
      end

      # Draw all children relative to this location.
      # TODO: If the dimensions of this group of this group are less than the computed dimensions, the drawing will be clipped.
      def draw
        super
        return self unless @draw

        draw_children
      end
    end
  end
end
