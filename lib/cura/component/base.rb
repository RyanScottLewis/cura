if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_focusability"
  require "cura/attributes/has_colors"
  require "cura/attributes/has_dimensions"
  require "cura/attributes/has_events"
  require "cura/attributes/has_offsets"
  require "cura/attributes/has_relative_coordinates"
  require "cura/attributes/has_visibility"
  require "cura/helpers/validations"
  require "cura/helpers/component/drawing"
  require "cura/component"
  require "cura/window"
end

module Cura
  module Component
    # The base class for all components.
    #
    # All components use a box model similar to CSS.
    # Margins, borders, paddings, then content.
    class Base

      class << self
        # On subclass hook.
        def inherited(subclass)
          super

          Component.all << subclass
        end

        # The type of this component class.
        #
        # @example
        #   Cura::Component::XMLTools::AttributeLabel.type # => :xml_tools_attribute_label
        # @return [Symbol]
        def type # TODO: Helper method for this sort of thing
          @type ||= to_s.gsub(/^Cura::Component::/, "")
                        .gsub(/([A-Z][A-Za-z]*)([A-Z][A-Za-z0-9_]*)/, "\\1_\\2")
                        .gsub(/::/, "_").downcase.to_sym
        end
      end

      include Helpers::Validations
      include Helpers::Component::Drawing

      include Attributes::HasInitialize
      include Attributes::HasAttributes

      include Attributes::HasAncestry
      include Attributes::HasDimensions
      include Attributes::HasEvents
      include Attributes::HasFocusability
      include Attributes::HasColors
      include Attributes::HasOffsets
      include Attributes::HasRelativeCoordinates
      include Attributes::HasVisibility

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

      # Get the window of this object.
      #
      # @return [Application]
      def window
        return nil if parent.nil?
        return nil if parent.is_a?(Cura::Application)
        return parent if parent.is_a?(Cura::Window)

        parent.window
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

      # Update this component.
      #
      # @return [Component]
      def update
        @draw = true

        self
      end

      # Draw this component.
      #
      # @return [Component]
      def draw
        return self unless @visible
        return self unless draw?

        draw_background
        draw_border

        self
      end

      # Get whether this component should be drawn.
      #
      # @return [Boolean]
      def draw?
        @draw
      end

      # Set whether this component should be drawn.
      #
      # @param [Boolean] value
      # @return [Boolean]
      def draw=(value)
        @draw = !!value
      end

      # Instance inspection.
      #
      # @return [String]
      def inspect
        "#<#{self.class}:0x#{__id__.to_s(16)} x=#{x} y=#{y} absolute_x=#{absolute_x} absolute_y=#{absolute_y} w=#{width} h=#{height} parent=#{@parent.class}:0x#{@parent.__id__.to_s(16)}>"
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
