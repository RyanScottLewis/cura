module Cura
  module Component
    
    class Textbox < Label
      
      on_event(:focus) do |event|
        if event.target == self
          set_cursor_position
          cursor.hidden = false if cursor.hidden?
        end
      end
      
      on_event(:unfocus) do |event|
        cursor.hidden = true if event.target == self
      end
      
      on_event(:key_down) do |event|
        if event.target == self
          self.text = text[0..-2] if event.key == Key.backspace
          self.text << " " if event.key == Key.space
          # self.text << "\n" if event.key == Key.enter # TODO: if multiline?
          self.text << event.character unless event.character.nil?
          
          set_cursor_position
        end
      end
      
      def initialize(attributes={})
        super
        
        @width  = 1 if @width < 1
        @height = 1 if @height < 1
      end
      
      # Clear all characters within this textbox.
      # 
      # @return [Textbox]
      def clear
        @text = ""
        redraw
        
        self
      end
      
      # Get the mask character for this textbox.
      # 
      # @return [String]
      attr_reader :mask_character
      
      # Set the mask character for this textbox.
      # Set to anything for a "password" textbox. Only the first character of whatever is given is used.
      # 
      # @param [String] value
      # @return [String]
      def mask_character=(value)
        value = value.to_s.strip[0]
        value = nil if value.empty?
        
        @mask_character = value
      end
      
      # Set the width of this textbox.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def width=(value)
        super
        
        @width = 1 if @width < 1
      end
      
      # Set the height of this textbox.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def height=(value)
        super
        
        @height = 1 if @height < 1
      end
      
      protected
      
      def text_to_draw
        return text if text.length <= width
        
        text[-width..-1]
      end
      
      def character_to_draw(character)
        mask_character.nil? ? character : mask_character
      end
      
      def set_cursor_position
        last_line_length = lines.last.nil? ? 0 : lines.last.length
        
        cursor.x = absolute_x + offsets.left + (text.length < width ? last_line_length : width-1)
        cursor.y = absolute_y + offsets.top + text_height - 1
      end
      
    end
    
  end
end
