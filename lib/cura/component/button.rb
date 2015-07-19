if Kernel.respond_to?(:require)
  require "cura/component/label"
end

module Cura
  module Component
    
    # A button component.
    class Button < Label
      
      on_event(:focus) do |event|
        switch_colors if event.target == self
      end
      
      on_event(:unfocus) do |event|
        switch_colors if event.target == self
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
        
        super
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
