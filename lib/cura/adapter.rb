if Kernel.respond_to?(:require)
  require 'cura/attributes/has_attributes'
end

module Cura
  
  # TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # How to use adapter system?
  # mixin = adapter.mixins[ component.class ]
  # component.extend( mixin ) if mixin && mixin.is_a?(Module)
  # TODO !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # The base class for adapters.
  class Adapter
    
    include Attributes::HasAttributes
    
    def initialize(attributes={})
      @mixins = {}
      
      super
    end
    
    # The mixins to apply per class.
    # Key is the class to mix into and the value is the module to mixin.
    # 
    # @return [Hash]
    attr_reader :mixins
    
    def setup
      
    end
    
    def clear
      
    end
    
    def cleanup
      
    end
    
  end
  
end
