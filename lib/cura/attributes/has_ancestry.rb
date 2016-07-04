if Kernel.respond_to?(:require)
  require "cura/error/invalid_component"
  require "cura/component/base"
end

module Cura
  module Attributes
    # Allows an object to have a `parent` and `ancestors`.
    module HasAncestry

      def initialize(attributes={})
        @ancestors = [].freeze

        super
      end

      # Get the parent of this object.
      #
      # @return [Component::Base]
      attr_accessor :parent

      # Set the parent of this object.
      # This modifies the state of the view tree.
      #
      # @param [Component::Base] value
      # @return [Component::Base]
      def parent=(value)
        raise Error::InvalidComponent unless value.is_a?(Component::Base)

        @parent = value
        @application.tree_controller.create_relation(@parent, self)

        @parent
      end

      # Determine if this object has a parent.
      #
      # @return [Boolean]
      def parent?
        !@parent.nil?
      end

      # Get the ancestors of this object.
      #
      # @return [<Object>]
      attr_reader :ancestors

      # Set the ancestors of this object.
      # This modifies the state of the view tree.
      #
      # @param [<Component::Base>] value
      # @return [<Component::Base>]
      def ancestors=(value)
        @ancestors = value.to_a.keep_if { |object| object.is_a?(Component::Base) }.freeze
      end

    end
  end
end
