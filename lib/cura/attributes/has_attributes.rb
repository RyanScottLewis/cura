module Cura
  module Attributes
    
    # Adds the `update_attributes` method.
    module HasAttributes
      
      module ClassMethods
        
        def attribute(name, options={}, &block)
          options = options.to_hash rescue options.to_h
          
          attr_reader(name)
          
          define_method("#{name}=") do |value|
            value = instance_exec(value, options, &block) if block_given?
            
            instance_variable_set( "@#{name}", value )
          end
        end
        
      end
      
      class << self
        
        def included(base)
          base.extend(ClassMethods)
        end
        
      end
      
      # Initialize this object by optionally updating attributes with a Hash.
      #
      # @param [#to_hash, #to_h] attributes Attributes to set after initializing.
      def initialize(attributes={})
        update_attributes(attributes)
        
        super
      end
      
      # Update any attributes on this object.
      #
      # @param [#to_hash, #to_h] attributes
      # @return [Hash] The attributes.
      def update_attributes(attributes={})
        attributes = convert_attributes(attributes)
        
        attributes.each { |name, value| send( "#{name}=", value ) }
      end
      
      protected
      
      VALID_SIZE_SYMBOLS = [ :auto, :inherit ]
      
      def validate_size_attribute(value)
        if value.is_a?(Symbol)
          raise ArgumentError, "must be one of #{ VALID_SIZE_SYMBOLS.join(', ') }" unless VALID_SIZE_SYMBOLS.include?(value)
        else
          value = value.to_i
          value = 0 if value < 0
        end
        
        value
      end
      
      # Convert the attributes to a Hash and any other conversions that may need to happen.
      #
      # @param [#to_hash, #to_h] attributes
      # @return [Hash] The attributes.
      def convert_attributes(attributes={})
        attributes.to_hash rescue attributes.to_h
      end
      
    end
    
  end
end
