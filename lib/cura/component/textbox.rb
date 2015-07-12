if Kernel.respond_to?(:require)
  require "cura/component/label"
  require "cura/key"
end

module Cura
  module Component
    
    # A component containing editable text.
    class Textbox < Label
      
      on_event(:focus) do
        set_cursor_position
        
        cursor.show
      end
      
      on_event(:unfocus) { cursor.hide }
      
      on_event(:key_down) do |event|
        if event.target == self
          if event.name == :backspace
            self.text = text[0..-2]
          elsif event.name == :space
            text << " "
          # elsif event.name == :enter # TODO: if multiline?
          #   self.text << "\n"
          elsif event.printable?
            text << event.character
          end

          set_cursor_position
        end
      end
      
      def initialize(attributes={})
        @focusable = true
        @foreground = Cura::Color.black
        @background = Cura::Color.white
        
        super
        
        # TODO
        # @width  = 1 if @width != :auto && @width < 1
        # @height = 1 if @height != :auto && @height < 1
      end
      
      # Clear all characters within this textbox.
      #
      # @return [Textbox]
      def clear
        @text = ""
        
        set_cursor_position
        
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

        focused? ? text[-width..-1] : text[0...width]
      end
      
      def character_to_draw(character)
        mask_character.nil? ? character : mask_character
      end
      
      def set_cursor_position
        last_line_length = lines.last.nil? ? 0 : lines.last.length
        
        cursor.x = absolute_x + offsets.left + (text.length < width ? last_line_length : width - 1)
        cursor.y = absolute_y + offsets.top + text_height - 1
      end
      
    end
    
  end
end
