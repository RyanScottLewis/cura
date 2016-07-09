if Kernel.respond_to?(:require)
  require "cura/component/base"
  require "cura/error/invalid_component"
  require "cura/helpers/validations"
end

module Cura
  module Attributes
    # Allows an object to have child components.
    # TODO: Lots of code is the same as HasWindows
    module HasChildren
      include Enumerable
      include Helpers::Validations

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
      # @param [Boolean] recursive Determines if the children should be gathered recursively to retrieve all of this object's decendants.
      # @return [<Component>]
      def children(recursive=false)
        if recursive
          @children.collect { |child| child.respond_to?(:children) ? [child] + child.children(true) : child }.flatten # TODO: Shouldn't flatten?
        else
          @children
        end
      end

      # Add a child to this group.
      #
      # If a Hash-like object is given, it must have the `:type` key which will be used to
      # determine which class to initialize. The rest of the Hash will be used to set the
      # attributes of the instance.
      #
      # @param [#to_sym, Component] component_or_type
      #   A Symbol representing the child component type or a {Component::Base} instance.
      #   When a Symbol is given, a new child component will be initialized of that type. See {Component::Base.type}.
      # @param [#to_h] attributes
      #   When component_or_type is a Class, then these attributes will be used to initialize the child component.
      #   When component_or_type is a Symbol, then these attributes will be used to initialize the child component.
      #   When component_or_type is a {Component::Base}, then these attributes will be used to update the child component.
      # @return [Component]
      def add_child(component_or_type, attributes={})
        component = if component_or_type.is_a?(Class)
          raise Error::InvalidComponent unless component_or_type < Component::Base

          component_or_type.new
        elsif component_or_type.respond_to?(:to_sym)
          type = component_or_type.to_sym
          component_class = Component.find_by_type(type)

          raise Error::InvalidComponent if component_class.nil?

          component_class.new
        else
          raise Error::InvalidComponent unless component_or_type.is_a?(Component::Base)

          component_or_type
        end

        component.update_attributes(attributes)

        @children << component

        component
      end

      # Add multiple children to this group.
      #
      # @param [<Component>] children
      # @return [<Component>]
      def add_children(*children)
        children.each { |child| add_child(child) }
      end

      # Remove a child from this object's children at the given index.
      #
      # @param [#to_i] index
      # @return [Component]
      def delete_child_at(index)
        @children.delete_at(index.to_i)
      end

      # Remove a child from this object's children.
      #
      # @param [Component] component
      # @return [Component]
      def delete_child(component)
        validate_type(component, Component::Base)

        delete_child_at(@children.index(component))
      end

      # Remove all children.
      #
      # @return [Group]
      def delete_children
        (0...@children.count).to_a.reverse_each { |index| delete_child_at(index) } # TODO: Why reverse?

        self
      end

      # Determine if this group has children.
      #
      # @return [Boolean]
      def children?
        @children.any?
      end

      # Determine if this group's children contains the given `component`.
      #
      # @return [Boolean]
      def has_child?(component)
        @children.include?(component)
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
