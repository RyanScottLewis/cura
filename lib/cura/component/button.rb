if Kernel.respond_to?(:require)
  require "cura/component/label"
end

module Cura
  module Component
    
    # A button component.
    class Button < Label
      
      on_event(:key_down) do |event|
        click if event.target == self && event.name == :enter
      end
      
      on_event(:mouse_button) do |event|
        click if event.target == self && event.up? && contains_coordinates?(x: event.x, y: event.y)
      end
      
      # @method focused_background
      # Get the focused background color of this object.
      #
      # @return [Color]
      
      # @method focused_background=(value)
      # Set the focused background color of this object.
      #
      # @param [Color] value
      # @return [Color]
      
      attribute(:focused_background) { |value| validate_color_attribute(value) }
      
      def initialize(attributes={})
        @focusable = true
        @foreground = Cura::Color.black
        @background = Cura::Color.white
        @focused_background = Color.new(78, 78, 78)
        
        super
      end
      
      def background
        focused? ? @focused_background : get_or_inherit_color(:background, Color.black)
      end
      
      # Click this button.
      #
      # @return [Button]
      def click
        application.dispatch_event(:click, target: self)
        
        self
      end
      
    end
    
  end
end
