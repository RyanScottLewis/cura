if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_attributes"
end

module Cura
  # Colors.
  class Color
    include Attributes::HasInitialize
    include Attributes::HasAttributes

    class << self
      # TODO: All standard color names

      # The default color to be overidden by adapters.
      # Usually, for TUI's to use the terminal theme's colors.
      # TODO: Remove.
      def default
        super
      end

      def black
        new
      end

      def white
        new(255, 255, 255)
      end

      def red
        new(255, 0, 0)
      end

      def green
        new(0, 255, 0)
      end

      def blue
        new(0, 0, 255)
      end
    end

    RGB_TO_LAB_CACHE = {}

    def initialize(r=0, g=0, b=0, a=255)
      if r.respond_to?(:to_h)
        super(r.to_h)
      else
        @red   = r
        @green = g
        @blue  = b
        @alpha = a
      end

      # TODO: Update on rgb setters?
      rgb = [@red, @green, @blue]
      @lab = (RGB_TO_LAB_CACHE[rgb] ||= rgb_to_lab(rgb))
      # @lab = rgb_to_lab(rgb)
    end

    # @method red
    # Get the red channel of this color.
    #
    # @return [Integer]

    # @method red=(value)
    # Set the red channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]

    # @method green
    # Get the green channel of this color.
    #
    # @return [Integer]

    # @method green=(value)
    # Set the green channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]

    # @method blue=(value)
    # Get the blue channel of this color.
    #
    # @return [Integer]

    # @method blue=(value)
    # Set the blue channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]

    # @method alpha
    # Get the alpha channel of this color.
    #
    # @return [Integer]

    # @method alpha=(value)
    # Set the alpha channel of this color.
    #
    # @param [#to_i] value
    # @return [Integer]

    [:red, :green, :blue, :alpha].each do |channel|
      attribute(channel) { |value| convert_and_constrain_value(value) }
    end

    attr_reader :lab

    def -(other)
      delta_e_2000(@lab, other.lab)
    end

    def <=>(other)
      hsl[0] <=> other.hsl[0]
    end

    # Determing if this color is equivalent to another object.
    #
    # @param [Object] other
    # @return [Boolean]
    def ==(other)
      other.is_a?(Color) ? matches_color?(other) : super
    end

    def hsl
      @hsl ||= rgb_to_hsl(@rgb)
    end

    def yiq
      @yiq ||= rgb_to_yiq(@rgb)
    end

    def to_a
      [@red, @green, @blue, @alpha]
    end

    def hex
      to_a.each_with_object("") { |part, memo| memo << "%02x" % part }
    end

    protected

    def matches_color?(other)
      @alpha == other.alpha && @red == other.red && @green == other.green && @blue && other.blue
    end

    # Convert the input to an Integer and constrain in or between 0 and 255.
    def convert_and_constrain_value(value)
      value = value.to_i

      [255, [0, value].max].min
    end

    # source: http://www.easyrgb.com/index.php?X=MATH&H=02#text2
    def rgb_to_xyz(color)
      r, g, b = color.map do |v|
        v /= 255.0
        if v > 0.04045
          v = ((v + 0.055) / 1.055)**2.4
        else
          v /= 12.92
        end
        v *= 100
      end

      # Observer = 2 degrees, Illuminant = D65
      x = r * 0.4124 + g * 0.3576 + b * 0.1805
      y = r * 0.2126 + g * 0.7152 + b * 0.0722
      z = r * 0.0193 + g * 0.1192 + b * 0.9505

      [x, y, z]
    end

    def xyz_to_lab(color)
      f = lambda do |t|
        return t**(1.0 / 3) if t > (6.0 / 29)**3
        return (1.0 / 3) * ((29.0 / 6)**2) * t + (4.0 / 29)
      end

      x, y, z = color
      xn, yn, zn = rgb_to_xyz([255, 255, 255])
      l = 116 * f.call(y / yn) - 16
      a = 500 * (f.call(x / xn) - f.call(y / yn))
      b = 200 * (f.call(y / yn) - f.call(z / zn))

      [l, a, b]
    end

    def rgb_to_lab(rgb_val)
      xyz_to_lab rgb_to_xyz rgb_val
    end

    def rgb_to_hsl(rgb_val)
      r, g, b = rgb_val.map { |v| v / 255.0 }

      min, max = [r, g, b].minmax
      delta = max - min

      lig = (max + min) / 2.0

      if delta == 0
        hue = 0
        sat = 0
      else
        sat = if lig < 0.5
          delta / (0.0 + (max + min))
        else
          delta / (2.0 - max - min)
        end

        delta_r = (((max - r) / 6.0) + (delta / 2.0)) / delta
        delta_g = (((max - g) / 6.0) + (delta / 2.0)) / delta
        delta_b = (((max - b) / 6.0) + (delta / 2.0)) / delta

        hue = case max
                when r then delta_b - delta_g
                when g then (1.0 / 3) + delta_r - delta_b
                when b then (2.0 / 3) + delta_g - delta_r
              end

        hue += 1 if hue < 0
        hue -= 1 if hue > 1
      end

      [360 * hue, 100 * sat, 100 * lig]
    end

    def rgb_to_yiq(rgb_val)
      r, g, b = rgb_val

      y = 0.299 * r + 0.587 * g + 0.114 * b
      i = 0.569 * r - 0.275 * g - 0.321 * b
      q = 0.212 * r - 0.523 * g + 0.311 * b

      [y, i, q]
    end

    def rad_to_deg(v)
      (v * 180) / Math::PI
    end

    def deg_to_rad(v)
      (v * Math::PI) / 180
    end

    def lab_to_hue(a, b)
      bias = 0
      return 0 if a >= 0 && b == 0
      return 180 if a < 0 && b == 0
      return 90 if a == 0 && b > 0
      return 270 if a == 0 && b < 0

      bias = case
        when a > 0 && b > 0 then 0
        when a < 0 then 180
        when a > 0 && b < 0 then 360
      end

      rad_to_deg(Math.atan(b / a)) + bias
    end

    def delta_e_2000(lab1, lab2)
      l1, a1, b1 = lab1
      l2, a2, b2 = lab2
      kl = 1
      kc = 1
      kh = 1

      xC1 = Math.sqrt(a1**2 + b1**2)
      xC2 = Math.sqrt(a2**2 + b2**2)
      xCX = (xC1 + xC2) / 2
      xGX = 0.5 * (1 - Math.sqrt(xCX**7 / (xCX**7 + 25**7)))
      xNN = (1 + xGX) * a1
      xC1 = Math.sqrt(xNN**2 + b1**2)
      xH1 = lab_to_hue(xNN, b1)
      xNN = (1 + xGX) * a2
      xC2 = Math.sqrt(xNN**2 + b2**2)
      xH2 = lab_to_hue(xNN, b2)
      xDL = l2 - l1
      xDC = xC2 - xC1
      if (xC1 * xC2) == 0
        xDH = 0
      else
        xNN = (xH2 - xH1).round(12)
        if xNN.abs <= 180
          xDH = xH2 - xH1
        else
          if xNN > 180
            xDH = xH2 - xH1 - 360
          else
            xDH = xH2 - xH1 + 360
          end
        end
      end
      xDH = 2 * Math.sqrt(xC1 * xC2) * Math.sin(deg_to_rad(xDH / 2.0))
      xLX = (l1 + l2) / 2.0
      xCY = (xC1 + xC2) / 2.0
      if xC1 * xC2 == 0
        xHX = xH1 + xH2
      else
        xNN = (xH1 - xH2).round(12).abs
        if xNN > 180
          if xH2 + xH1 < 360
            xHX = xH1 + xH2 + 360
          else
            xHX = xH1 + xH2 - 360
          end
        else
          xHX = xH1 + xH2
        end
        xHX /= 2.0
      end
      xTX = 1 - 0.17 * Math.cos(deg_to_rad(xHX - 30)) + 0.24 * Math.cos(deg_to_rad(2 * xHX)) + 0.32 * Math.cos(deg_to_rad(3 * xHX + 6)) - 0.20 * Math.cos(deg_to_rad(4 * xHX - 63))
      xPH = 30 * Math.exp(-((xHX - 275) / 25.0) * ((xHX - 275) / 25.0))
      xRC = 2 * Math.sqrt(xCY**7 / (xCY**7 + 25**7))
      xSL = 1 + ((0.015 * ((xLX - 50) * (xLX - 50))) /
            Math.sqrt(20 + ((xLX - 50) * (xLX - 50))))
      xSC = 1 + 0.045 * xCY
      xSH = 1 + 0.015 * xCY * xTX
      xRT = -Math.sin(deg_to_rad(2 * xPH)) * xRC
      xDL /= (kl * xSL)
      xDC /= (kc * xSC)
      xDH /= (kh * xSH)

      Math.sqrt(xDL**2 + xDC**2 + xDH**2 + xRT * xDC * xDH)
    end
  end
end
