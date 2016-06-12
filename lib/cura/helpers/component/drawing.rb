if Kernel.respond_to?(:require)
  require "cura/color"
end

module Cura
  module Helpers
    module Component

      # Helpers for drawing within components.
      module Drawing

        protected

        # Draw a point.
        def draw_point(x, y, color=Cura::Color.black)
          x = absolute_x + @offsets.left + x
          y = absolute_y + @offsets.top + y

          pencil.draw_point(x, y, color)
        end

        # Draw a rectangle.
        # TODO: filled argument
        def draw_rectangle(x, y, width, height, color=Cura::Color.black)
          x = absolute_x + @offsets.left + x
          y = absolute_y + @offsets.top + y

          pencil.draw_rectangle(x, y, width, height, color)
        end

        # Draw a single character.
        def draw_character(x, y, character, foreground=Cura::Color.black, background=Cura::Color.white, bold=false, underline=false)
          x = absolute_x + @offsets.left + x
          y = absolute_y + @offsets.top + y

          pencil.draw_character(x, y, character, foreground, background, bold, underline)
        end

        # Draw text.
        def draw_text(x, y, text, foreground=Cura::Color.black, background=Cura::Color.white, bold=false, underline=false)
          x = absolute_x + @offsets.left + x
          y = absolute_y + @offsets.top + y

          pencil.draw_text(x, y, text, foreground, background, bold, underline)
        end

        # Draw the background of this component.
        def draw_background
          x      = absolute_x + @margin.left + @border.left
          y      = absolute_y + @margin.top + @border.top
          width  = self.width + @padding.width
          height = self.height + @padding.height
          color  = background

          pencil.draw_rectangle(x, y, width, height, color)
        end

        # Draw the border of this component.
        def draw_border # TODO
        end

      end

    end
  end
end
