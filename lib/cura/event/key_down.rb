module Cura
  module Event
    
    # Dispatched when is key's state changes from up to down.
    class KeyDown < Base
      
      # Get the key sequence (such as Termbox::KEY_CTRL_C, etc.)
      attr_reader :key
      
      # Set the key sequence (such as Termbox::KEY_CTRL_C, etc.)
      def key=(value)
        raise TypeError, 'key must respond to #to_i' unless value.respond_to?(:to_i)
        
        @key = value.to_i
      end
      
      # Get the character of this key press.
      attr_reader :character
      
      # Set the character of this key press.
      def character=(value)
        @character = value.to_s
      end
      
    end
    
  end
end
