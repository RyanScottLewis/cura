if Kernel.respond_to?(:require)
  require "cura/helpers/validations"
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
  require "cura/component/base"
end

module Cura
  # The offsets of a component's drawing area.
  class Offsets
    include Helpers::Validations
    include Attributes::HasInitialize
    include Attributes::HasAttributes

    def initialize(attributes={})
      super

      raise ArgumentError, "component must be set" if @component.nil?
    end

    # Get the component to calculate offsets for.
    #
    # @return [Component]
    attr_reader :component

    # Set the component to calculate offsets for.
    #
    # @param [Component] value
    # @return [Component]
    def component=(value)
      @component = validate_type(value, Component::Base)
    end

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

    # Get the sum of all of the given attributes on the padding, border, and margin.
    #
    # @param [Symbol] method
    # @return [Integer]
    def attribute_sum(method)
      @component.padding.send(method) + @component.border.send(method) + @component.margin.send(method)
    end
  end
end
