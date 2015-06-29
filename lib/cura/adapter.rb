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
      
      def mixins
        @mixins ||= {}
      end
      
      def mixin(value)
        value = value.to_hash rescue value.to_h 
        
        mixins.merge!(value)
      end
      
    end
    
    include Attributes::HasInitialize
    include Attributes::HasAttributes
    
    def initialize(attributes={})
      @setup = false
      
      super
    end
    
    def setup
      @setup = true
      
      self.class.mixins.each { |type, mod| type.send( :include, mod ) }
      
      self
    end
    
    def setup?
      @setup
    end
    
    def clear
      
    end
    
    def cleanup
      @setup = false
      
      self
    end
    
  end
  
end
