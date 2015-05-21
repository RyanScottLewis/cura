if Kernel.respond_to?(:require)
  require 'cura/event/base'
end

module Cura
  module Event
    
    # Dispatched when is key's state changes from up to down.
    class KeyDown < Base
      
      # Get if the key was a control character.
      # 
      # @return [Boolean]
      def control_key?
        @control_key
      end
      
      # Set if the key was a control character.
      # 
      # @param [Boolean] value
      # @return [Boolean]
      def control_key=(value)
        @control_key = !!value
      end
      
      # Get the key code.
      # 
      # @return [Integer]
      attr_reader :key_code
      
      # Set the key code.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def key_code=(value)
        @key_code = value.to_i
      end
      
      # Get the character of this key, if there is one.
      # 
      # @return [nil, String]
      def character
        return nil if control_key?
        
        [@key_code].pack(?U) # UTF-8 character from key code
      end
      
      # Get the name of this key, if it is a control character.
      # 
      # @return [nil, String]
      def key_name
        return nil unless control_key?
        
        Key.name_from_code(@key_code)
      end
      
    end
    
  end
end
