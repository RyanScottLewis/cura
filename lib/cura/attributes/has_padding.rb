if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/padding'
end

module Cura
  module Attributes
    
    # Adds the `padding` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasPadding
      
      include HasAttributes
      
      def initialize(attributes={})
        attributes[:padding] ||= {}
        attributes[:padding] = attributes[:padding].to_hash rescue attributes[:padding].to_h
        
        @padding = Padding.new( attributes[:padding] )
        
        super
      end
      
      # Get the padding of this object.
      # 
      # @return [Padding]
      attr_reader :padding
      
      # Set the padding of this object.
      # 
      # @param [Padding, #to_hash, #to_h] value
      # @return [Padding]
      def padding=(value)
        @padding = if value.is_a?(Padding)
          value
        else
          value = value.to_hash rescue value.to_h
          
          Padding.new(value)
        end
      end
      
    end
    
  end
end
