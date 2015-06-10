if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_coordinates'
end

module Cura
  
  # The text cursor controller.
  # 
  # Should only ever have one single Cursor instance at one time.
  # TODO: Rename Cursor::Text, need Cursor::Mouse
  class Cursor
    
    include Attributes::HasInitialize
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    
    def initialize(attributes={})
      @hidden = true
      
      super
      
      raise ArgumentError, 'application must be set' if application.nil?
    end
    
    # Check if the cursor is hidden.
    def hidden?
      !!@hidden
    end
    
    # Set if the cursor is hidden.
    def hidden=(value)
      value = !!value
      
      @hidden = value
    end
    
    # Draw (set) the cursor.
    def draw
      if @hidden
        application.adapter.hide_cursor
      else
        application.adapter.set_cursor( @x, @y )
      end
    end
    
  end
  
end
