if Kernel.respond_to?(:require)
  require "cura/component/label"
end

module Cura
  module Component
    
    # A button component.
    class Button < Label
      
      on_event(:focus) do |event|
        @inverted = true if event.target == self
      end
      
      on_event(:unfocus) do |event|
        @inverted = false if event.target == self
      end
      
      on_event(:key_down) do |event|
        click if event.target == self && event.name == :enter
      end
      
      on_event(:mouse_button) do |event|
        click if event.target == self && event.up? && contains_coordinates?(x: event.x, y: event.y)
      end
      
      def initialize(attributes={})
        @focusable = true
        @foreground = Cura::Color.black
        @background = Cura::Color.white
        @inverted = false
        
        super
      end
      
      def background
        @inverted ? get_or_inherit_color(:foreground, Color.white) : get_or_inherit_color(:background, Color.black)
      end
      
      def foreground
        @inverted ? get_or_inherit_color(:background, Color.black) : get_or_inherit_color(:foreground, Color.white)
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
