if Kernel.respond_to?(:require)
  require 'cura/margins'
end

module Cura
  module Attributes
    
    # Adds the `margins` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasMargins
      
      include HasAttributes
      
      def initialize(attributes={})
        attributes[:margins] ||= {}
        attributes[:margins] = attributes[:margins].to_hash rescue attributes[:margins].to_h
        
        @margins = Margins.new( attributes[:margins] )
        
        super
      end
      
      # Get the margins of this object.
      # 
      # @return [Margins]
      attr_reader :margins
      
      # Set the margins of this object.
      # 
      # @param [Margins, #to_hash, #to_h] value
      # @return [Margins]
      def margins=(value)
        @margins = if value.is_a?(Margins)
          value
        else
          value = value.to_hash rescue value.to_h
          
          Margins.new(value)
        end
      end
      
    end
    
  end
end
