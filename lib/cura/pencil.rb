module Cura
  
  # The tool used for drawing on a surface.
  class Pencil
    
    # Draw a point.
    def draw_point(x, y, color=Cura::Color.black)
      super
    end
    
    # Draw a rectangle.
    # TODO: filled argument
    def draw_rectangle(x, y, width, height, color=Cura::Color.black)
      super
    end
    
    # Draw a single character.
    def draw_character(x, y, character, foreground=Cura::Color.black, background=Cura::Color.white, bold=false, underline=false)
      super
    end
    
    # Draw text.
    def draw_text(x, y, text, foreground=Cura::Color.black, background=Cura::Color.white, bold=false, underline=false)
      super
    end
    
  end
  
end
