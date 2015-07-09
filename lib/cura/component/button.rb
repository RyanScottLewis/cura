if Kernel.respond_to?(:require)
  require 'cura/component/label'
end

module Cura
  module Component
    
    class Button < Label
      
      on_event(:focus) do |event|
        switch_foreground_and_background if event.target == self
      end
      
      on_event(:unfocus) do |event|
        switch_foreground_and_background if event.target == self
      end
      
      on_event(:key_down) do |event|
        click if event.target == self && event.name == :enter
      end
      
      on_event(:mouse_down) do |event|
        click if event.target == self
      end
      
      def initialize(attributes={})
        @focusable = true
        @foreground, @background = Cura::Color.black, Cura::Color.white
        
        super
      end
      
      # Click this button.
      #
      # @return [Button]
      def click
        application.dispatch_event( :click, target: self )
        
        self
      end
      
    end
    
  end
end
