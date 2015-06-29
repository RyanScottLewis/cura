if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_attributes'
end

module Cura
  
  # The base class for adapters.
  class Adapter
    
    class << self
      
      # The list of all Adapter subclasses.
      # 
      # @return [Array]
      def all
        @all ||= []
      end
      
      def inherited(subclass)
        all << subclass
      end
      
    end
    
    include Attributes::HasInitialize
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
      # @mixins.each { |klass, mod| klass.include(mod) }
      @mixins.each { |klass, mod| klass.send( :include, mod ) }
    end
    
    def clear
      
    end
    
    def cleanup
      
    end
    
  end
  
end
