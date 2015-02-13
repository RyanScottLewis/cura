if Kernel.respond_to?(:require)
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_coordinates'
end

module Cura
  
  # The text cursor controller.
  # 
  # Should only ever have one single Cursor instance at one time.
  # TODO: Rename Cursor::Text, need Cursor::Mouse
  class Cursor
    
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    
    def initialize(attributes={})
      @hidden = true
      
      super
      
      raise ArgumentError, 'application must be set' if application.nil?
    end
    
    # Set the X coordinate of the cursor.
    def x=(value)
      super
      
      redraw
    end
    
    # Set the Y coordinate of the cursor.
    def y=(value)
      super
      
      redraw
    end
    
    # Check if the cursor is hidden.
    def hidden?
      !!@hidden
    end
    
    # Set if the cursor is hidden.
    def hidden=(value)
      value = !!value
      
      @hidden = value
      
      redraw
    end
    
    # Queue all objects for drawing during the next loop cycle.
    def redraw
      application.redraw
    end
    
    # Draw (set) the cursor.
    def draw
      adapter.set_cursor( cursor_x, cursor_y )
    end
    
  end
  
end
