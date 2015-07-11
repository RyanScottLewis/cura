if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_attributes'
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
        new( red: 255, green: 255, blue: 255 )
      end
      
      def red
        new( red: 255, green: 0, blue: 0 )
      end
      
      def green
        new( red: 0, green: 255, blue: 0 )
      end
      
      def blue
        new( red: 0, green: 0, blue: 255 )
      end
      
    end
    
    def initialize(attributes={})
      @red, @green, @blue = 0, 0, 0
      
      super
    end
    
    # The amount of red in this color.
    #
    # @return [Integer]
    attr_reader :red
    
    # Set the amount of red in this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    def red=(value)
      @red = convert_and_constrain_value(value)
    end
    
    # The amount of green in this color.
    #
    # @return [Integer]
    attr_reader :green
    
    # Set the amount of green in this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    def green=(value)
      @green = convert_and_constrain_value(value)
    end
    
    # The amount of blue in this color.
    #
    # @return [Integer]
    attr_reader :blue
    
    # Set the amount of blue in this color.
    #
    # @param [#to_i] value
    # @return [Integer]
    def blue=(value)
      @blue = convert_and_constrain_value(value)
    end
    
    # Determing if this color is equivalent to another object.
    #
    # @param [Object] other
    # @return [Boolean]
    def ==(other)
      if other.is_a?(Color)
        red == other.red && green == other.green && blue && other.blue
      else
        super
      end
    end
    
    protected
    
    # Convert the input to an Integer and constrain in or between 0 and 255
    def convert_and_constrain_value(value)
      value = value.to_i
      
      [ 255, [ 0, value ].max ].min
    end
    
  end
  
end
