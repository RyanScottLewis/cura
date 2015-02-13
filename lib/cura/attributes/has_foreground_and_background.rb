module Cura
  module Attributes
    
    # Adds the #foreground and #background attributes.
    # TODO: Should be color and background... HasBackground and HasColor
    module HasForegroundAndBackground
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        @foreground, @background = Cura::Color.default, Cura::Color.default
        
        super
      end
      
      # Get the foreground color of this object.
      attr_reader :foreground
      
      # Set the foreground color of this object.
      def foreground=(value)
        raise ArgumentError, "foreground must respond to :to_i" unless value.respond_to?(:to_i)
        
        @foreground = value.to_i
      end
      
      # Get the background color of this object.
      attr_reader :background
      
      # Set the background color of this object.
      def background=(value)
        raise ArgumentError, "background must respond to :to_i" unless value.respond_to?(:to_i)
        
        @background = value.to_i
      end
      
    end
    
  end
end
