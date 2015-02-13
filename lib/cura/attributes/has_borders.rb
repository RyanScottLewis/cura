if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
  require 'cura/borders'
end

module Cura
  module Attributes
    
    # Adds the `borders` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasBorders
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        attributes[:borders] ||= {}
        attributes[:borders] = attributes[:borders].to_hash rescue attributes[:borders].to_h
        
        @borders = Borders.new( attributes[:borders] )
        
        super
      end
      
      # Get the borders of this object.
      # 
      # @return [Borders]
      attr_reader :borders
      
      # Set the borders of this object.
      # 
      # @param [Borders, #to_hash, #to_h] value
      # @return [Borders]
      def borders=(value)
        @borders = if value.is_a?(Borders)
          value
        else
          value = value.to_hash rescue value.to_h
          
          Borders.new(value)
        end
      end
      
    end
    
  end
end
