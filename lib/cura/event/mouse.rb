if Kernel.respond_to?(:require)
  require "cura/event/base"
end

module Cura
  module Event
    
    # Dispatched when a mouse's button state changes.
    class Mouse < Base
      
      # Get the X coordinate where the mouse button was pressed.
      #
      # @return [Integer]
      attr_reader :x
      
      # Get the Y coordinate where the mouse button was pressed.
      #
      # @return [Integer]
      attr_reader :y
      
      protected
      
      def x=(value)
        @x = value.to_i
      end
      
      def y=(value)
        @y = value.to_i
      end
      
    end
    
  end
end
