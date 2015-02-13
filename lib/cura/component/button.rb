module Cura
  module Component
    
    class Button < Label
      
      def initialize(attributes={}, &block)
        @callback = block if block_given?
        @clicked = false
        
        super
      end
      
      # Get the state of this button.
      attr_reader :state
      
      # Click this button.
      def click
        @clicked = true
        
        switch_foreground_and_background
        execute_callback_if_needed
      end
      
      # Get or set the callback of this button.
      # TODO: Should /all/ components have a callback? Like FLTK? Kinda stupid..
      def callback(&block)
        @callback = block if block_given?
        
        @callback
      end
      
      def draw
        super
        
        if @clicked
          @clicked = false
          
          invert_colors
        end
        
        self
      end
      
      protected
      
      def execute_callback_if_needed
        instance_eval(&@callback) unless @callback.nil?
      end
      
    end
    
  end
end
