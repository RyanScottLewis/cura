module Cura
  module Attributes
    
    # Adds the `attr_object` class method, which defines an attribute with an object as it's value.
    module HasObjectAttributes
      
      module ClassMethods
        
        def attr_object(name, type)
          attr_reader(name)
          
          define_method("#{name}=") do |value|
            value ||= {}
            
            result = if value.is_a?(type)
              value
            else
              value = value.to_hash rescue value.to_h
              
              type.new(value)
            end
            
            instance_variable_set( "@#{name}", result )
          end
        end
        
      end
      
      class << self
        
        def included(base)
          base.extend(ClassMethods)
        end
        
      end
      
    end
    
  end
end
