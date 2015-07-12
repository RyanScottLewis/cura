if Kernel.respond_to?(:require)
  require "cura/attributes/has_attributes"
end

module Cura
  module Attributes
    
    # Adds the `focusable` attribute to objects.
    module HasFocusability
      
      include HasAttributes
      
      def initialize(attributes={})
        @focusable = false unless instance_variable_defined?(:@focusable)
        
        super
      end
      
      # Get whether this object is focusable or not.
      # 
      # @return [Boolean]
      def focusable?
        @focusable
      end
      
      # Set whether this object is focusable or not.
      # 
      # @param [Object] value
      # @return [Boolean]
      def focusable=(value)
        @focusable = !!value
      end
      
    end
    
  end
end
