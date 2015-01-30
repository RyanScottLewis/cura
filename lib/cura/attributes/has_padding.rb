module Cura
  module Attributes
    
    # Adds the `padding` attribute to objects.
    # TODO: Lots of repeated code in HasMargins, HasPadding, and HasBorders
    module HasPadding
      
      include Attributes::HasAttributes
      
      def initialize(attributes={})
        attributes[:padding] ||= {}
    
        raise TypeError, ':padding option must respond to #to_hash or #to_h' unless attributes[:padding].respond_to?(:to_hash) || attributes[:padding].respond_to?(:to_h)
        attributes[:padding] = attributes[:padding].to_hash rescue attributes[:padding].to_h
        
        @padding = Padding.new( attributes[:padding] )
        
        super
      end
      
      # Get the padding of this object.
      attr_reader :padding
      
      # Set the padding of this object.
      # 
      # @param value [Padding] The new Padding instance.
      def padding=(value)
        raise TypeError, ':padding option must be a Padding instance or respond to #to_hash or #to_h' unless value.respond_to?(:to_hash) || value.respond_to?(:to_h)
        
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
