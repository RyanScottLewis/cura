module Cura
  module Attributes
    
    # Adds the `borders` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasBorders
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        attributes[:borders] ||= {}
    
        raise TypeError, ':borders option must respond to #to_hash or #to_h' unless attributes[:borders].respond_to?(:to_hash) || attributes[:borders].respond_to?(:to_h)
        attributes[:borders] = attributes[:borders].to_hash rescue attributes[:borders].to_h
        
        @borders = Borders.new( attributes[:borders] )
        
        super
      end
      
      # Get the borders of this object.
      attr_reader :borders
      
      # Set the borders of this object.
      # 
      # @param value [Borders] The new Borders instance.
      def borders=(value)
        raise TypeError, ':borders option must be a Borders instance or respond to #to_hash or #to_h' unless value.respond_to?(:to_hash) || value.respond_to?(:to_h)
        
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
