if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_application"
  require "cura/attributes/has_children"
  require "cura/attributes/has_coordinates"
  require "cura/attributes/has_dimensions"
  require "cura/attributes/has_events"
  require "cura/attributes/has_root"
  require "cura/focus_controller"
end

module Cura
  # A window containing a drawing area.
  class Window
    include Attributes::HasInitialize
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    include Attributes::HasEvents
    include Attributes::HasRoot

    on_event(:key_down) do |event|
      @focus_controller.index += 1 if event.name == :tab
    end

    def initialize(attributes={})
      super

      @focus_controller = FocusController.new(window: self)
    end

    # Update this window's components.
    #
    # @return [Window]
    def update
      @root.update

      self
    end

    # Draw this window's children.
    #
    # @return [Window]
    def draw
      application.adapter.clear
      @root.draw
      application.adapter.present

      self
    end

    # Show this window.
    #
    # @return [Window]
    def show
      self # TODO
    end

    # Hide this window.
    #
    # @return [Window]
    def hide
      self # TODO
    end

    # Return this window's parent.
    #
    # @return [Window]
    def parent # TODO: Needed?
      @application
    end

    # Set root component for this object.
    #
    # @param [Component::Group] component
    # @return [Component::Group]
    def root=(value)
      raise TypeError, "root must be a Component::Group" unless value.is_a?(Component::Group)

      @root.parent = nil unless @root.nil?

      @root = value
      @root.parent = self
      @root.focus

      @root
    end

    # Instance inspection.
    #
    # @return [String]
    def inspect
      "#<#{self.class}:0x#{__id__.to_s(16)} application=#{@application.class}:0x#{@application.__id__.to_s(16)}>"
    end
  end
end
