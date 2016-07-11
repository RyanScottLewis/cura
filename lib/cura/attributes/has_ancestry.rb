if Kernel.respond_to?(:require)
  require "cura/helpers/conversions"

  require "cura/attributes/has_application"

  require "cura/tree_controller"
end

module Cura
  module Attributes
    # Allows an object to have a `parent` and `ancestors`.
    module HasAncestry
      include HasApplication
      include Helpers::Conversions

      def initialize(attributes={})
        @ancestors = [].freeze

        super
      end

      # Get the parent of this object.
      #
      # @return [Component::Base]
      attr_reader :parent

      # Get whether this object has a parent.
      #
      # @return [Boolean]
      def parent?
        !@parent.nil?
      end

      # Set the parent of this object.
      #
      # @param [Component::Base] value
      # @return [Component::Base]
      def parent=(value)
        @application.tree_controller.create_relation(value, self)

        @parent
      end

      # Set the parent of this object.
      #
      # Usage of this method does not update any other aspects of the relationship between the parent and this
      # component and should only be used internally.
      #
      # @param [Component::Base] value
      # @return [Component::Base]
      def set_parent(value)
        validate_type(value, Component::Base)

        @parent = value
      end

      # Get the ancestors of this object.
      #
      # @return [<Component::Base>]
      attr_reader :ancestors

      # Set the ancestors of this object.
      # This modifies the state of the view tree.
      #
      # @param [<Component::Base>] value
      # @return [<Component::Base>]
      def ancestors=(value)
        @ancestors = convert_array_instances(value, Component::Base).freeze
      end

    end
  end
end
