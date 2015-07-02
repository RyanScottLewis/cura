if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_attributes'
  require 'cura/component/base'
end

module Cura
  
  class Offsets
    
    include Attributes::HasInitialize
    include Attributes::HasAttributes
    
    def initialize(attributes={})
      super
      
      raise ArgumentError, 'component must be set' if @component.nil?
    end
    
    # Get the component to calculate offsets for.
    # 
    # @return [Component]
    attr_reader :component
    
    # Set the component to calculate offsets for.
    # 
    # @param [Component] value
    # @return [Component]
    def component=(value)
      raise TypeError, 'value must be a Cura::Component::Base' unless value.is_a?(Cura::Component::Base)
      
      @component = value
    end
    
    # Get the top offset from the contents of a component from the top.
    # 
    # @return [Integer]
    def top
      @component.margin.top + @component.border.top
    end
    
    # Get the right offset from the contents of a component from the right.
    # 
    # @return [Integer]
    def right
      @component.margin.right + @component.border.right
    end
    
    # Get the bottom offset from the contents of a component from the bottom.
    # 
    # @return [Integer]
    def bottom
      @component.margin.bottom + @component.border.bottom
    end
    
    # Get the left offset from the contents of a component from the left.
    # 
    # @return [Integer]
    def left
      @component.margin.left + @component.border.left
    end
    
    # Get the full height of offsets of a component.
    # 
    # @return [Integer]
    def height
      top + bottom
    end
    
    # Get the full width of offsets of a component.
    # 
    # @return [Integer]
    def width
      left + right
    end
    
  end
  
end
