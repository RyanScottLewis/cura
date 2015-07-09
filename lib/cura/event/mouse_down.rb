if Kernel.respond_to?(:require)
  require 'cura/event/mouse'
end

module Cura
  module Event
    
    # Dispatched when a mouse's button state changes from up to down.
    class MouseDown < Mouse
      
      def initialize(attributes={})
        super
        
        raise ArgumentError, 'name must be set' if @name.nil?
      end
      
      # Get the mouse button name.
      # Will return `:left`, `:middle`, or `:right`.
      #
      # @return [Integer]
      attr_reader :name
      
      # Get whether the mouse button pressed the left button.
      #
      # @return [Boolean]
      def left?
        @name == :left
      end
      
      # Get whether the mouse button pressed the middle button.
      #
      # @return [Boolean]
      def middle?
        @name == :middle
      end
      
      # Get whether the mouse button pressed the right button.
      #
      # @return [Boolean]
      def right?
        @name == :right
      end
      
      protected
      
      VALID_NAMES = [ :left, :middle, :right ]
      
      # Set the mouse button name.
      #
      # @param [#to_sym] value
      # @return [String]
      def name=(value)
        raise ArgumentError, "must be one of #{ VALID_NAMES.join(', ') }" unless VALID_NAMES.include?(value)
        
        @name = value.to_sym
      end
      
    end
    
  end
end
