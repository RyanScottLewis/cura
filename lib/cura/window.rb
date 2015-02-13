if Kernel.respond_to?(:require)
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_children'
  require 'cura/attributes/has_coordinates'
  require 'cura/attributes/has_dimensions'
end

module Cura
  
  # A window containing a drawing area.
  class Window
    
    include Attributes::HasApplication
    include Attributes::HasChildren
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    
    # Update this window's components.
    # 
    # @return [Application] This application.
    def update
      update_children
      
      self
    end
    
    # Draw this window's children.
    # 
    # @return [Application] This application.
    def draw
      adapter.clear
      
      draw_children
      # @application.cursor.draw # TODO
      
      adapter.present
      
      @redraw = false
      
      self
    end
    
    # Queue all children for drawing during the next loop cycle.
    # 
    # @return [Application] This application.
    def redraw
      @redraw = true
      
      self
    end
    
    # Get whether all children will redraw in the next loop cycle.
    # 
    # @return [Boolean]
    def redraw?
      @redraw == true
    end
    
  end
  
end
