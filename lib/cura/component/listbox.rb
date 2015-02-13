module Cura
  module Component
    
    class Listbox < Pack
      
      on_event(:focus) { |event| selected_child.switch_foreground_and_background }
      
      on_event(:unfocus) { |event| selected_child.switch_foreground_and_background }
      
      on_event(:key_down) do |event|
        self.selected_index -= 1 if event.key == Key.arrow_up && selected_index != 0
        self.selected_index += 1 if event.key == Key.arrow_down && selected_index != children.count-1
        
        if event.key == Key.enter
          application.dispatch_event( :selected )
          
          false
        end
        
      end
      
      def initialize(attributes={})
        @selected_index = 0
        
        super
      end
      
      # Get the currently selected item's index.
      # Returns `nil` is nothing is selected.
      # 
      # @return [nil, Integer]
      attr_reader :selected_index
      
      # Set the currently selected item's index.
      # Set to `nil` if nothing is selected.
      # 
      # @param [nil, #to_i] value
      # @return [nil, Integer]
      def selected_index=(value)
        raise ArgumentError, 'selected_index must respond to :to_i' unless value.respond_to?(:to_i)
        
        selected_child.switch_foreground_and_background if focused?
        @selected_index = value.to_i
        selected_child.switch_foreground_and_background if focused?
        
        @selected_index
      end
      
      # Get the child at the selected index.
      # 
      # @return [Component]
      def selected_child
        @children[ @selected_index ]
      end
      
    end
    
  end
end
