if Kernel.respond_to?(:require)
  require 'cura/component/pack'
  require 'cura/key'
end

module Cura
  module Component
    
    class Listbox < Pack
      
      on_event(:focus) do |event|
          set_cursor_position
          cursor.show
      end
      
      on_event(:unfocus) do |event|
        cursor.hide
      end
      
      on_event(:key_down) do |event|
        self.selected_index -= 1 if event.name == :up && @selected_index != 0
        self.selected_index += 1 if event.name == :down && @selected_index != @children.count-1
        # TODO: Loop around query attribute to determine if to loop around after pressing down on the last item or up on the first
        
        if event.name == :enter
          application.dispatch_event( :selected )
          
          false
        end
        
      end
      
      def initialize(attributes={})
        @focusable = true
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
        
        @selected_index = value.to_i
        
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
      
      protected
      
      def set_cursor_position
        cursor.x = @children.empty? ? absolute_x : selected_child.absolute_x
        cursor.y = @children.empty? ? absolute_y : selected_child.absolute_y
      end
      
    end
    
  end
end
