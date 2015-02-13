if Kernel.respond_to?(:require)
  require 'cura/event/base'
end

module Cura
  module Event
    
    # Dispatched when is key's state changes from up to down.
    class KeyDown < Base
      
      # Get the key code.
      # 
      # @return [Integer]
      attr_reader :key_code
      
      # Set the key code.
      # 
      # @param [#to_i] value
      # @return [Integer]
      def key=(value)
        @key = value.to_i
      end
      
    end
    
  end
end
