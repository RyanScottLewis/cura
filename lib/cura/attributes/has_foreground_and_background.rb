if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/attributes/has_ancestry'
  
  require 'cura/color'
end

module Cura
  module Attributes
    
    # Adds the #foreground and #background attributes.
    # TODO: Should be color and background... HasBackground and HasColor
    module HasForegroundAndBackground
      
      include HasAttributes
      include HasAncestry
      
      def initialize(attributes={})
        @foreground = Cura::Color.white unless instance_variable_defined?(:@foreground)
        @background = :inherit unless instance_variable_defined?(:@background)
        
        super
      end
      
      # Get the foreground color of this object.
      # 
      # @return [Color]
      attr_reader :foreground
      
      # Set the foreground color of this object.
      # 
      # @param [Color] value
      # @return [Color]
      def foreground=(value)
        raise ArgumentError, 'foreground must be a Cura::Color' unless value.is_a?(Cura::Color)
        
        @foreground = value
      end
      
      # Get the background color of this object.
      # 
      # @return [Color]
      def background
        return @background unless @background == :inherit
        return Cura::Color.default unless parent? && parent.respond_to?(:background)
        
        parent.background
      end
      
      # Set the background color of this object.
      # 
      # @param [Color] value
      # @return [Color]
      def background=(value)
        unless value.is_a?(Cura::Color)
          begin
            value = value.to_sym
          rescue
            raise ArgumentError, 'foreground must be a Symbol or Cura::Color'
          end
        end
        
        @background = value
      end
      
    end
    
  end
end
