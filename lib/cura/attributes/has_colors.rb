if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  
  require 'cura/error/invalid_color'
  
  require 'cura/color'
end

module Cura
  module Attributes
    
    # Adds the #foreground and #background attributes.
    # TODO: Should be color and background... HasBackground and HasColor
    module HasColors
      
      include HasAttributes
      
      def initialize(attributes={})
        @foreground = :inherit unless instance_variable_defined?(:@foreground)
        @background = :inherit unless instance_variable_defined?(:@background)
        
        super
      end
      
      # Get the foreground color of this object.
      #
      # @return [Color]
      def foreground
        get_or_inherit_color(:background, Color.black)
      end
      
      # Set the foreground color of this object.
      #
      # @param [Color] value
      # @return [Color]
      def foreground=(value)
        @foreground = validate_color_attribute(value)
      end
      
      # Get the background color of this object.
      #
      # @return [Color]
      def background
        get_or_inherit_color(:background, Color.white)
      end
      
      # Set the background color of this object.
      #
      # @param [Color] value
      # @return [Color]
      def background=(value)
        @background = validate_color_attribute(value)
      end
      
      protected
      
      def get_or_inherit_color(name, default)
        value = instance_variable_get("@#{name}")
        
        return value unless value == :inherit
        return default unless respond_to?(:parent) && parent.respond_to?(name)
        
        parent.send(name)
      end
      
      def validate_color_attribute(value)
        unless value.is_a?(Cura::Color)
          begin
            value = value.to_sym
            
            raise unless value == :inherit
          rescue
            raise Error::InvalidColor
          end
        end
        
        value
      end
      
    end
    
  end
end
