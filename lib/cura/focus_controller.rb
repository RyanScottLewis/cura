if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
  require "cura/attributes/has_application"
end

module Cura
  class FocusController
    include Attributes::HasInitialize
    include Attributes::HasAttributes
    include Attributes::HasApplication

    def initialize(attributes={})
      @index = 0

      super

      # TODO: raise error if window or application is nil
    end

    # Get the window of the currently focused component.
    #
    # @return [Window]
    attr_reader :window

    # Set the window of the currently focused component.
    #
    # @param [#to_i] value
    # @return [Window]
    def window=(value)
      @window = validate_window(value)
    end

    # Get the index of the currently focused component.
    #
    # @return [Integer]
    attr_reader :index

    # Set the index of the currently focused component.
    # This will dispatch a Event::Focus instance to the object.
    #
    # @param [#to_i] value
    # @return [Integer]
    def index=(value)
      @index = set_index(value)
    end

    protected

    def validate_window(window)
      raise TypeError, "must be a Cura::Window" unless window.is_a?(Window)

      window
    end

    def set_index(value)
      index = value.to_i
      focusable_children = focusable_children_of(@window.root)
      index %= focusable_children.length

      @window.application.dispatcher.target = focusable_children[index]

      index
    end

    # TODO: When on a focusable component, set the index. When not on a focusable component, find nearest focusable component and set the index.
    # def update_focused_index(component)
    #   focusable_children = focusable_children_of(@window.root)
    #
    #   @index = focusable_children.index(component)
    # end

    # Recursively find all children which are focusable.
    def focusable_children_of(component)
      result = []

      component.children.each do |child|
        result << child if child.focusable?
        result << focusable_children_of(child) if child.respond_to?(:children)
      end

      result.flatten
    end
  end
end
