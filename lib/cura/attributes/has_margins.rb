module Cura
  module Attributes
    
    # Adds the `margins` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasMargins
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        attributes[:margins] ||= {}
    
        raise TypeError, ':margins option must respond to #to_hash or #to_h' unless attributes[:margins].respond_to?(:to_hash) || attributes[:margins].respond_to?(:to_h)
        attributes[:margins] = attributes[:margins].to_hash rescue attributes[:margins].to_h
        
        @margins = Margins.new( attributes[:margins] )
        
        super
      end
      
      # Get the margins of this object.
      attr_reader :margins
      
      # Set the margins of this object.
      # 
      # @param value [Margins] The new Margins instance.
      def margins=(value)
        raise TypeError, ':margins option must be a Margins instance or respond to #to_hash or #to_h' unless value.respond_to?(:to_hash) || value.respond_to?(:to_h)
        
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
