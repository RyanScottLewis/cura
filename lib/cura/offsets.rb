module Cura
  
  class Offsets
    
    include Attributes::HasAttributes
    include Attributes::HasBorders
    include Attributes::HasMargins
    
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
      raise TypeError, 'value must be a Component' unless value.is_a?(Component)
      
      @component = value
    end
    
    # Get the top offset from the contents of a component from the top.
    # 
    # @return [Integer]
    def top
      @component.margins.top + @component.borders.top
    end
    
    # Get the right offset from the contents of a component from the right.
    # 
    # @return [Integer]
    def right
      @component.margins.right + @component.borders.right
    end
    
    # Get the bottom offset from the contents of a component from the bottom.
    # 
    # @return [Integer]
    def bottom
      @component.margins.bottom + @component.borders.bottom
    end
    
    # Get the left offset from the contents of a component from the left.
    # 
    # @return [Integer]
    def left
      @component.margins.left + @component.borders.left
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
