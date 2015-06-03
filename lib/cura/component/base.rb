if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_foreground_and_background'
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
      include Attributes::HasForegroundAndBackground
      include Attributes::HasOffsets
      include Attributes::HasRelativeCoordinates
      
      # Get the outer width of this component.
      # This is the dimension including any borders, margins, or padding sizes.
      # 
      # @return [Integer]
      def outer_width
        width + offsets.width + padding.width
      end
      
      # Get the outer width of this component.
      # This is the dimension including any borders, margins, or padding sizes.
      # 
      # @return [Integer]
      def outer_height
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
      
      # Queue all objects for drawing during the next loop cycle.
      # TODO: Delegate
      # 
      # @return [Application]
      def redraw
        application.redraw
      end
      
      # Update this component.
      def update
        # NOTE: Does nothing here on purpose.
      end
      
      # Draw this component.
      # 
      # @return [Component] This component.
      def draw
        draw_background
        draw_borders
        
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
      # @return [Component] This component.
      def focus
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
      # @option option [#to_i] :x
      # @option option [#to_i] :y
      # @return [Hash] The new coordinates.
      def translate(options={})
        options = options.to_hash rescue options.to_h
        
        {
          x: absolute_x + options[:x].to_i,
          y: absolute_y + options[:y].to_i
        }
      end
      
      # Instance inspection.
      # 
      # @return [String]
      def inspect
        "#<#{self.class} x=#{@x} y=#{@y} w=#{@width} h=#{@height} parent=#{@parent.class}>"
      end
      
      protected
      
      # Draw the background of this component.
      def draw_background
        options = translate( x: offsets.left, y: offsets.top ).merge( width: width, height: height, foreground: foreground, background: background )
        
        pencil.draw_rectangle( options )
      end
      
      # Draw the borders of this component.
      def draw_borders # TODO
        if borders.top > 0 # TODO: :none
          options = translate( x: margins.left, y: margins.top ).merge( width: width + margins.width, height: borders.top, foreground: borders.foreground, background: Color.red )
          
          pencil.draw_rectangle( options )
        end
        
        if borders.bottom > 0 # TODO: :none
          options = translate( x: margins.left, y: offsets.top + padding.bottom ).merge( width: width + margins.width, height: borders.bottom, foreground: borders.foreground, background: Color.red )
          
          pencil.draw_rectangle( options )
        end
      end
      
      def switch_foreground_and_background
        f, b = foreground, background
        
        self.foreground, self.background = b, f
        
        redraw
      end
      
    end
    
  end
end
