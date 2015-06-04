if Kernel.respond_to?(:require)
  require 'cura/component/label'
  require 'cura/key'
end

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
          if event.key_name == :backspace
            self.text = text[0..-2]
          elsif event.key_name == :space
            self.text << ' '
          elsif event.key_name == :return # TODO: if multiline?
            # self.text << "\n"
          elsif !event.control_key?
            self.text << event.character
          end

          set_cursor_position
        end
      end
      
      def initialize(attributes={})
        super
        
        @foreground, @background = Cura::Color.black, Cura::Color.white
        
        @width  = 1 if @width != :auto && @width < 1
        @height = 1 if @height != :auto && @height < 1
      end
      
      # Clear all characters within this textbox.
      # 
      # @return [Textbox]
      def clear
        @text = ''
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
