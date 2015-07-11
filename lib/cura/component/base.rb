if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_focusability'
  require 'cura/attributes/has_colors'
  require 'cura/attributes/has_dimensions'
  require 'cura/attributes/has_events'
  require 'cura/attributes/has_offsets'
  require 'cura/attributes/has_relative_coordinates'
end

module Cura
  module Component
    
    # The base class for all components.
    #
    # All components use a box model similar to CSS.
    # Margins, borders, paddings, then content.
    class Base
      
      include Attributes::HasInitialize
      include Attributes::HasDimensions
      include Attributes::HasEvents
      include Attributes::HasFocusability
      include Attributes::HasColors
      include Attributes::HasOffsets
      include Attributes::HasRelativeCoordinates
      
      # Get the outer width of this component.
      # This is the dimension including any borders, margins, or padding sizes.
      #
      # @return [Integer]
      def outer_width # TODO: Remove
        width + offsets.width + padding.width
      end
      
      # Get the outer width of this component.
      # This is the dimension including any borders, margins, or padding sizes.
      #
      # @return [Integer]
      def outer_height # TODO: Remove
        height + offsets.height + padding.height
      end
      
      # Get the cursor for this application.
      # TODO: Delegate
      #
      # @return [Cursor]
      def cursor
        application.cursor
      end
      
      # Get the pencil for this application.
      # TODO: Delegate
      #
      # @return [Pencil]
      def pencil
        application.pencil
      end
      
      # Update this component.
      #
      # @return [Component]
      def update
        self
      end
      
      # Draw this component.
      #
      # @return [Component]
      def draw
        draw_background
        draw_border
        
        self
      end
      
      # Get the application of this object.
      #
      # @return [Application]
      def application
        return nil if parent.nil?
        
        parent.application
      end
      
      # Focus on this component.
      #
      # @return [nil, Component] This component or nil if it isn't focusable.
      def focus
        return nil unless @focusable
        
        application.focus(self)
      end
      
      # Check whether this component is focused.
      #
      # @return [Boolean]
      def focused?
        application.focused == self # TODO: application.focused?(self)
      end
      
      # Translate absolute coordinates to relative coordinates.
      #
      # @param [#to_hash, #to_h] options
      # @option options [#to_i] :x
      # @option options [#to_i] :y
      # @return [Hash] The new coordinates.
      def translate(options={})
        options = options.to_hash rescue options.to_h
        
        {
          x: absolute_x + options[:x].to_i,
          y: absolute_y + options[:y].to_i
        }
      end
      
      # Get the foreground color of this object.
      #
      # @return [Color]
      def foreground
        get_or_inherit_color( :foreground, Color.black )
      end
      
      # Get the background color of this object.
      #
      # @return [Color]
      def background
        get_or_inherit_color( :background, Color.white )
      end
      
      # Instance inspection.
      #
      # @return [String]
      def inspect
        "#<#{self.class}:0x#{__id__.to_s(16)} x=#{x} y=#{y} absolute_x=#{absolute_x} absolute_y=#{absolute_y} w=#{width} h=#{height} parent=#{@parent.class}:0x#{@parent.__id__.to_s(16)}>"
      end
      
      protected
      
      # Draw the background of this component.
      def draw_background
        options = translate( x: @offsets.left, y: @offsets.top ).merge( width: width + @padding.width, height: height + @padding.height, foreground: foreground, background: background )
        
        pencil.draw_rectangle( options )
      end
      
      # Draw the border of this component.
      def draw_border # TODO
        if border.top > 0 # TODO: :none
          options = translate( x: margin.left, y: margin.top ).merge( width: width + margin.width, height: border.top, foreground: border.foreground, background: Color.red )
          
          pencil.draw_rectangle( options )
        end
        
        if border.bottom > 0 # TODO: :none
          options = translate( x: margin.left, y: offsets.top + padding.bottom ).merge( width: width + margin.width, height: border.bottom, foreground: border.foreground, background: Color.red )
          
          pencil.draw_rectangle( options )
        end
      end
      
      def switch_colors
        f, b = foreground, background
        
        self.foreground, self.background = b, f
      end
      
      def get_or_inherit_color(name, default)
        value = instance_variable_get("@#{name}")
        
        return value unless value == :inherit
        return default unless respond_to?(:parent) && parent.respond_to?(name)
        
        parent.send(name)
      end
      
    end
    
  end
end
