if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"

  require "cura/component/group"
end

module Cura
  module Attributes
    # Adds the `root` attribute to an object, which defaults to a Component::Group.
    module HasRoot
      include Attributes::HasApplication
      include Attributes::HasAttributes

      def initialize(attributes={})
        @root = Component::Group.new(parent: self, application: @application)

        super
      end

      # Get root component for this object.
      #
      # @return [Component::Group]
      attr_reader :root

      # Set root component for this object.
      #
      # @param [Component::Group] component
      # @return [Component::Group]
      def root=(value)
        raise TypeError, "root must be a Component::Group" unless value.is_a?(Component::Group)

        @root = value
      end

      # Delegates -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
      # TODO: Use Forwardable

      # Get the children of this object.
      #
      # @return [<Component>]
      def children(recursive=false)
        @root.children(recursive)
      end

      # Add a child to this object's root component.
      #
      # @param [#to_sym, Component] component_or_type
      #   A Symbol representing the child component type or a {Component::Base} instance.
      #   When a Symbol is given, a new child component will be initialized of that type. See {Component::Base.type}.
      # @param [#to_h] attributes
      #   When component_or_type is a Symbol, then these attributes will be used to initialize the child component.
      #   When component_or_type is a {Component::Base}, then these attributes will be used to update the child component.
      # @return [Component]
      def add_child(component_or_type, attributes={})
        @root.add_child(component_or_type, attributes)
      end

      # Add multiple children to this object's root component.
      #
      # @param [<Component>] children
      # @return [<Component>]
      def add_children(*children)
        @root.add_children(*children)
      end

      # Remove a child from object's root component at the given index.
      #
      # @param [Integer] index
      # @return [Component]
      def delete_child_at(index)
        @root.delete_child_at(index)
      end

      # Remove a child from this object's root component.
      #
      # @param [Component] component
      # @return [Component]
      def delete_child(component)
        @root.delete_child(component)
      end

      # Remove all children from object's root component.
      #
      # @return [HasChildren]
      def delete_children
        @root.delete_children
      end

      # Determine if this object's root component has children.
      #
      # @return [Boolean]
      def children?
        @root.children?
      end

    end
  end
end
