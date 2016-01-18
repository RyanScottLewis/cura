if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
  require "cura/component/base"
end

module Cura
  # The offsets of a component's drawing area.
  class Offsets
    include Attributes::HasInitialize
    include Attributes::HasAttributes

    def initialize(attributes={})
      super

      raise ArgumentError, "component must be set" if @component.nil?
    end

    # @method component
    # Get the component to calculate offsets for.
    #
    # @return [Component]

    # @method component=(value)
    # Set the component to calculate offsets for.
    #
    # @param [Component] value
    # @return [Component]
    attribute(:component) { |value| validate_component(value) }

    # Get the top offset from the contents of a component from the top.
    #
    # @return [Integer]
    def top
      attribute_sum(:top)
    end

    # Get the right offset from the contents of a component from the right.
    #
    # @return [Integer]
    def right
      attribute_sum(:right)
    end

    # Get the bottom offset from the contents of a component from the bottom.
    #
    # @return [Integer]
    def bottom
      attribute_sum(:bottom)
    end

    # Get the left offset from the contents of a component from the left.
    #
    # @return [Integer]
    def left
      attribute_sum(:left)
    end

    # Get the full height of offsets of a component.
    #
    # @return [Integer]
    def height
      # top + bottom
      attribute_sum(:height)
    end

    # Get the full width of offsets of a component.
    #
    # @return [Integer]
    def width
      # left + right
      attribute_sum(:width)
    end

    protected

    def attribute_sum(method)
      @component.padding.send(method) + @component.border.send(method) + @component.margin.send(method)
    end

    def validate_component(value)
      raise TypeError, "value must be a Cura::Component::Base" unless value.is_a?(Cura::Component::Base)

      value
    end
  end
end
