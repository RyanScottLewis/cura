module Cura
  
  class Pencil
    
    # Change a cell relative to this widget's coordinates.
    def draw_cell(options={})
      options = convert_cell_drawing_options(options)
      options = convert_cell_drawing_character_option_to_unicode(options)
      
      Termbox.change_cell( options[:x], options[:y], options[:character], options[:foreground], options[:background] )
    end
    
    # Change a rectangle of cells relative to this widget's coordinates.
    # TODO: :filled option
    def draw_rectangle(options={})
      options = convert_rectangle_drawing_options(options)
      options = convert_cell_drawing_character_option_to_unicode(options)
      
      options[:width].times do |x_offset|
        options[:height].times do |y_offset|
          Termbox.change_cell( options[:x]+x_offset, options[:y]+y_offset, options[:character], options[:foreground], options[:background] )
        end
      end
    end
    
    protected
    
    # TODO: Widget drawing should be it's own module or class?
    
    def convert_cell_drawing_options(options)
      options = options.to_hash rescue options.to_h
      
      options = { x: 0, y: 0, foreground: Termbox::DEFAULT, background: Termbox::DEFAULT }.merge(options)
      
      options[:x]          = options[:x].to_i
      options[:y]          = options[:y].to_i
      options[:foreground] = options[:foreground].to_i
      options[:background] = options[:background].to_i
      
      options
    end
    
    def convert_rectangle_drawing_options(options)
      options = convert_cell_drawing_options(options)
      
      options = { width: 1, height: 1 }.merge(options)
      
      options[:width]  = options[:width].to_i
      options[:height] = options[:height].to_i
      
      options[:width]  = 1 if options[:width] < 1
      options[:height] = 1 if options[:height] < 1
      
      options
    end
    
    # Convert options[:character] to unicode.
    # TODO: Is utf8_char_to_unicode even needed at this point?
    def convert_cell_drawing_character_option_to_unicode(options)
      options[:character] = Termbox.utf8_char_to_unicode( options[:character].to_s[0] ) unless options[:character].nil?
      options[:character] ||= 0
      
      options
    end
    
  end
  
end
