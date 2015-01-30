module Cura
  
  # A window containing a drawing area.
  class Window
    
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    
    # Update this application.
    # 
    # @return [Application] This application.
    def update
      update_children
      
      self
    end
    
    # Draw this application.
    # 
    # @return [Application] This application.
    def draw
      Termbox.clear
      
      draw_children
      cursor.draw
      
      Termbox.present
      
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
