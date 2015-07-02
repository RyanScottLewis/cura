if Kernel.respond_to?(:require)
  require 'cura/component/pack'
  require 'cura/key'
end

module Cura
  module Component
    
    class Listbox < Pack
      
      on_event(:focus) do |event|
        if event.target == self
          set_cursor_position
          cursor.show
        end
      end
      
      on_event(:unfocus) do |event|
        cursor.hide if event.target == self
      end
      
      on_event(:key_down) do |event|
        if event.target == self
          update_selected_index_if_needed(event)
          application.dispatch_event( :selected ) if event.name == :enter
        end
      end
      
      def initialize(attributes={})
        @focusable = true
        @loopable = true
        @selected_index = 0
        @index_object_map = {}
        
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
        value = value.to_i
        
        if @loopable
          # Avoids value = value % 0 (divide by zero error)
          value = count == 0 ? 0 : value % count
        else
          value = 0 if value <= 0
          value = count-1 if value >= count-1
        end
        
        @selected_index = value
        
        set_cursor_position
        
        @selected_index
      end
      
      # Get the child at the selected index.
      # 
      # @return [Component]
      def selected_child
        @children[ @selected_index ]
      end
      
      # Remove a child from this listbox's children at the given index.
      # 
      # @param [#to_i] index
      # @return [Component]
      def delete_child_at(index)
        deleted_child = super
        
        self.selected_index = @children.length-1 if @selected_index >= @children.length
        
        deleted_child
      end
      
      # Get whether this listbox is loopable or not.
      # 
      # @return [Boolean]
      def loopable?
        @loopable
      end
      
      # Set whether this listbox is loopable or not.
      # 
      # @param [Object] value
      # @return [Boolean]
      def loopable=(value)
        @loopable = !!value
      end
      
      protected
      
      def set_cursor_position
        cursor.x = @children.empty? ? absolute_x : selected_child.absolute_x
        cursor.y = @children.empty? ? absolute_y : selected_child.absolute_y
      end
      
      def update_selected_index_if_needed(event)
        self.selected_index -= 1 if event.name == :up
        self.selected_index += 1 if event.name == :down
      end
      
    end
    
  end
end
