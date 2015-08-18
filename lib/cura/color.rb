if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
end

module Cura
  
  # Colors.
  class Color
    
    include Attributes::HasInitialize
    include Attributes::HasAttributes
    
    class << self
      
      # The default color to be overidden by adapters.
      # Usually, for TUI's to use the terminal theme's colors.
      # TODO: Remove.
      def default
        super
      end
      
      def black
        new
      end
      
      def white
        new(red: 255, green: 255, blue: 255)
      end
      
      def red
        new(red: 255, green: 0, blue: 0)
      end
      
      def green
        new(red: 0, green: 255, blue: 0)
      end
      
      def blue
        new(red: 0, green: 0, blue: 255)
      end
      
    end
    
    def initialize(attributes={})
      @alpha = 255
      @red   = 0
      @green = 0
      @blue  = 0
      
      super
    end
    
    # @method alpha
    # Get the alpha channel of this color.
    #
    # @return [Integer]
    
    # @method alpha=(value)
    # Set the alpha channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    
    # @method red
    # Get the red channel of this color.
    #
    # @return [Integer]
    
    # @method red=(value)
    # Set the red channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    
    # @method green
    # Get the green channel of this color.
    #
    # @return [Integer]
    
    # @method green=(value)
    # Set the green channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    
    # @method blue=(value)
    # Get the blue channel of this color.
    #
    # @return [Integer]
    
    # @method blue=(value)
    # Set the blue channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    
    [:alpha, :red, :green, :blue].each do |channel|
      attribute(channel) { |value| convert_and_constrain_value(value) }
    end
    
    # Determing if this color is equivalent to another object.
    #
    # @param [Object] other
    # @return [Boolean]
    def ==(other)
      other.is_a?(Color) ? matches_color?(other) : super
    end
    
    protected
    
    def matches_color?(other)
      @alpha == other.alpha && @red == other.red && @green == other.green && @blue && other.blue
    end
    
    # Convert the input to an Integer and constrain in or between 0 and 255.
    def convert_and_constrain_value(value)
      value = value.to_i
      
      [255, [0, value].max].min
    end
    
  end
  
end
