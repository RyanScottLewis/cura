module Cura
  module Attributes
    
    # Allows an object to have a `parent` and `ancestors`.
    module HasAncestry
      
      def initialize(attributes={})
        @ancestors = []
        
        super
      end
      
      # Get the parent of this object.
      # It's not recommended to set this directly as it will break the ancestory chain.
      # 
      # @return [Object]
      attr_reader :parent
      
      # Set the parent of this object.
      # It's not recommended to set this directly as it will break the ancestory chain.
      # 
      # @param [Object] value
      # @return [Object]
      def parent=(value)
        @parent = value
        
        set_ancestors
        
        @parent
      end
      
      # Determine if this object has a parent.
      # 
      # @return [Boolean]
      def parent?
        !@parent.nil?
      end
      
      # Get the ancestors of this object.
      # 
      # @return [Array<Object>]
      attr_reader :ancestors
      
      protected
      
      def set_ancestors
        @ancestors = []
        current_ancestor = self
        
        while !current_ancestor.nil?
          
          if current_ancestor.respond_to?(:parent)
            @ancestors << current_ancestor
            current_ancestor = current_ancestor.parent
          else
            current_ancestor = nil
          end
          
        end
        
        @ancestors
      end
      
    end
    
  end
end
