if Kernel.respond_to?(:require)
  require "cura/component/pack"
  require "cura/key"
end

module Cura
  module Component
    
    # A component containing a selectable list of components.
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
          self.selected_index -= 1 if event.name == :up
          self.selected_index += 1 if event.name == :down
        end
      end
      
      on_event(:mouse_button) do |event|
        if event.target == self && event.down?
          child = @children.find { |child| child.contains_coordinates?(x: event.x, y: event.y) }
          
          self.selected_index = @children.index(child) unless child.nil?
        end
      end
      
      on_event(:selected) do |event|
        set_cursor_position if event.target == self && focused?
      end
      
      def initialize(attributes={})
        @focusable = true
        @loopable = true
        @selected_index = 0
        @objects = []
        
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
          value = count == 0 ? 0 : value % count # Avoids value = value % 0 (divide by zero error)
        else
          value = 0 if value <= 0
          value = count - 1 if value >= count - 1
        end
        
        @selected_index = value
        
        application.dispatch_event(:selected, target: self)
        
        @selected_index
      end
      
      # Get the child at the selected index.
      #
      # @return [Component]
      def selected_child
        @children[@selected_index]
      end
      
      # Add a child to this group.
      #
      # @param [Component] component
      # @param [Object] object An arbitrary object to associate with the added child in this listbox.
      # @return [Component]
      def add_child(component, object=nil)
        child = super(component)

        @objects << object

        child
      end
      
      # Remove a child from this listbox's children at the given index.
      #
      # @param [#to_i] index
      # @return [Component]
      def delete_child_at(index)
        deleted_child = super
        
        @objects.delete_at(index)
        self.selected_index = @children.length - 1 if @selected_index >= @children.length
        
        deleted_child
      end
      
      # Get the associated object with the child at the given index.
      #
      # @param [#to_i] index
      # @return [Object]
      def object_at(index)
        @objects[index]
      end
      
      # Get the object associated with the child at the selected index.
      #
      # @return [Component]
      def selected_object
        @objects[@selected_index]
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
      
    end
    
  end
end
