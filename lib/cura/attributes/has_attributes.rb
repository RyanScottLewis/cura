module Cura
  module Attributes
    
    # Adds the `update_attributes` method.
    module HasAttributes
      
      # Initialize this object by optionally updating attributes with a Hash.
      def initialize(attributes={})
        update_attributes(attributes)
      end
      
      # Update any attributes on this object.
      def update_attributes(attributes={})
        attributes = attributes.to_hash rescue attributes.to_h
        
        attributes.each { |name, value| send( "#{name}=", value ) }
      end
      
    end
    
  end
end
