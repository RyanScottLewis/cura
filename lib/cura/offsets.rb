module Cura
  
  class Offsets
    
    include Attributes::HasAttributes
    
    def initialize(attributes={})
      super
      
      raise ArgumentError, 'widget attribute must be set' if @widget.nil?
    end
    
    # Get the widget to calculate offsets for.
    # 
    # @return [Widget]
    attr_reader :widget
    
    # Set the widget to calculate offsets for.
    # 
    # @param [Widget] value
    # @return [Widget]
    def widget=(value)
      raise TypeError, 'value must be a Widget' unless value.is_a?(Widget)
      
      @widget = value
    end
    
    # Get the top offset from the contents of a widget from the top.
    # 
    # @return [Integer]
    def top
      @widget.margins.top + @widget.borders.top
    end
    
    # Get the right offset from the contents of a widget from the right.
    # 
    # @return [Integer]
    def right
      @widget.margins.right + @widget.borders.right
    end
    
    # Get the bottom offset from the contents of a widget from the bottom.
    # 
    # @return [Integer]
    def bottom
      @widget.margins.bottom + @widget.borders.bottom
    end
    
    # Get the left offset from the contents of a widget from the left.
    # 
    # @return [Integer]
    def left
      @widget.margins.left + @widget.borders.left
    end
    
    # Get the full height of offsets of a widget.
    # 
    # @return [Integer]
    def height
      top + bottom
    end
    
    # Get the full width of offsets of a widget.
    # 
    # @return [Integer]
    def width
      left + right
    end
    
  end
  
end
