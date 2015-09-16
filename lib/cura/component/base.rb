if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_focusability"
  require "cura/attributes/has_colors"
  require "cura/attributes/has_dimensions"
  require "cura/attributes/has_events"
  require "cura/attributes/has_offsets"
  require "cura/attributes/has_relative_coordinates"
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
      
      # Get the cursor for this application.
      # TODO: Delegate something like: def_delegate(:cursor) { application }
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
      
      # Get the application of this object.
      #
      # @return [Application]
      def application
        return nil if parent.nil?
        
        parent.application
      end
      
      # Focus on this component.
      #
      # @return [Component]
      def focus
        application.dispatcher.target = self
      end
      
      # Check whether this component is focused.
      #
      # @return [Boolean]
      def focused?
        application.dispatcher.target == self
      end
      
      # Determine if the given absolute coordinates are within the bounds of this component.
      #
      # @param [#to_h] options
      # @option options [#to_i] :x
      # @option options [#to_i] :y
      # @return [Boolean]
      def contains_coordinates?(options={})
        options = options.to_h
        
        (absolute_x..absolute_x + width).include?(options[:x].to_i) && (absolute_y..absolute_y + width).include?(options[:y].to_i)
      end
      
      # Get the foreground color of this object.
      #
      # @return [Color]
      def foreground
        get_or_inherit_color(:foreground, Color.black)
      end
      
      # Get the background color of this object.
      #
      # @return [Color]
      def background
        get_or_inherit_color(:background, Color.white)
      end
      
      # Instance inspection.
      #
      # @return [String]
      def inspect
        "#<#{self.class}:0x#{__id__.to_s(16)} x=#{x} y=#{y} absolute_x=#{absolute_x} absolute_y=#{absolute_y} w=#{width} h=#{height} parent=#{@parent.class}:0x#{@parent.__id__.to_s(16)}>"
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
      
      protected
      
      def draw_character(x, y, character, foreground=Cura::Color.black, background=Cura::Color.white, bold=false, underline=false)
        x = absolute_x + @offsets.left + x
        y = absolute_y + @offsets.top + y
        
        pencil.draw_character(x, y, character, foreground, background, bold, underline)
      end
      
      # Draw the background of this component.
      def draw_background
        x      = absolute_x + @margin.left + @border.left
        y      = absolute_y + @margin.top + @border.top
        width  = self.width + @padding.width
        height = self.height + @padding.height
        color  = background
        
        pencil.draw_rectangle(x, y, width, height, color)
      end
      
      # Draw the border of this component.
      def draw_border # TODO
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
