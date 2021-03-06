if Kernel.respond_to?(:require)
  require "cura/component/base"
  require "cura/attributes/has_attributes"
end

module Cura
  module Component
    # A component displaying text.
    class Label < Base
      include Attributes::HasAttributes

      # Note that you can pass the following:
      #   alignment: { horizontal: true, vertical: true }
      # instead of:
      #   horizontal_alignment: true, vertical_alignment: true
      def initialize(attributes={})
        @horizontal_alignment = :left
        @vertical_alignment = :top
        @bold = false
        @underline = false
        @text = ""

        super
      end

      # TODO: #text_foreground, #text_background (? Maybe a separate Text component, like in )

      # Get the width of this label.
      #
      # @return [Integer]
      def width
        return text_width if @width == :auto

        @width
      end

      # Get the height of this label.
      #
      # @return [Integer]
      def height
        return text_height if @height == :auto

        @height
      end

      # Get the text of this label.
      #
      # @return [String]
      attr_reader :text

      # Set the text of this label.
      #
      # @param [#to_s] value
      # @return [String]
      def text=(value)
        @text = value.to_s
      end

      # Get the lines of this label.
      #
      # @return [<String>]
      def lines
        @text.split("\n") # NOTE: Would use String#lines but it's output doesn't think a trailing newline character constitutes a line unless it is followed by another character. #split also removes the newline characters.
      end

      # Get the width of the text of this label.
      #
      # @return [Integer]
      def text_width
        return 0 if @text.empty?

        lines.collect(&:length).sort.last
      end

      # Get the height of the text of this label.
      #
      # @return [Integer]
      def text_height
        value = lines.length

        value == 0 ? 1 : value
      end

      # Get whether the text is bold.
      #
      # @return [Boolean]
      attr_reader :bold?

      # Set whether the text is bold.
      #
      # @return [Boolean]
      def bold=(value)
        @bold = !!value
      end

      # Get whether the text is underlined.
      #
      # @return [Boolean]
      def underline?
        @underline
      end

      # Set whether the text is underlined.
      #
      # @return [Boolean]
      def underline=(value)
        @underline = !!value
      end

      # Get the horizontal alignment of this label.
      #
      # @return [Symbol]
      attr_reader :horizontal_alignment

      # Set the horizontal alignment of this label.
      # Must be :left, :center, or :right.
      #
      # @param [#to_sym] value
      # @return [Symbol]
      def horizontal_alignment=(value)
        @horizontal_alignment = convert_horizontal_alignment_attribute(value)
      end

      # Get the vertical alignment of this label.
      # Will be :left, :center, or :right.
      #
      # @return [Symbol]
      attr_reader :vertical_alignment

      # Set the vertical alignment of this label.
      # Must be :left, :center, or :right.
      #
      # @param [#to_sym] value
      # @return [Symbol]
      def vertical_alignment=(value)
        @vertical_alignment = convert_vertical_alignment_attribute(value)
      end

      def draw
        super
        return self unless @draw

        draw_text unless text.empty?
      end

      protected

      # Helper method for subclasses
      def text_to_draw
        @text
      end

      # Helper method for subclasses
      def character_to_draw(character)
        character
      end

      # TODO: Should use instance vars
      def draw_text
        x_offset = x_offset_start = x_offset_from_alignment # + @offsets.left
        y_offset = y_offset_from_alignment # + @offsets.top
        absolute_x = self.absolute_x
        absolute_y = self.absolute_y

        text_to_draw.each_char do |character|
          if character == "\n" # TODO: If multiline? Also check if outside the bounds of the drawing area
            x_offset = x_offset_start

            y_offset += 1
          else
            unless x_offset > width || y_offset > height
              character = character_to_draw(character)
              draw_character(x_offset, y_offset, character, foreground, background, @bold, @underline)
            end

            x_offset += 1
          end
        end
      end

      def x_offset_from_alignment
        case horizontal_alignment
          when :left   then 0
          when :center then ((text_width - width).abs / 2).to_i
          when :right  then (text_width - width).abs
        end
      end

      def y_offset_from_alignment
        case vertical_alignment
          when :top    then 0
          when :center then ((text_height - height).abs / 2).to_i
          when :bottom then (text_height - height).abs
        end
      end

      protected

      # TODO: Just use a #alignment attribute and have a Cura::Alignment object?
      def convert_attributes(attributes={})
        attributes = super

        if attributes.key?(:alignment)
          alignment_attributes = attributes.delete(:alignment).to_h

          attributes[:horizontal_alignment] = alignment_attributes[:horizontal] if alignment_attributes.key?(:horizontal)
          attributes[:vertical_alignment] = alignment_attributes[:vertical] if alignment_attributes.key?(:vertical)
        end

        attributes
      end

      def convert_horizontal_alignment_attribute(value)
        value = value.to_sym
        raise ArgumentError, "must be :left, :center, or :right" unless [:left, :center, :right].include?(value)

        value
      end

      def convert_vertical_alignment_attribute(value)
        value = value.to_sym
        raise ArgumentError, "must be :top, :center, or :bottom" unless [:top, :center, :bottom].include?(value)

        value
      end
    end
  end
end
