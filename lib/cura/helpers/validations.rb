if Kernel.respond_to?(:require)
  require "cura/color"
  require "cura/error/invalid_color"
end

module Cura
  module Helpers
    # Protected validations which always return the value passed for ease of use.
    module Validations

      VALID_SIZE_SYMBOLS = [:auto, :inherit]

      protected

      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
      # -= General                                                                             =- #
      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

      def validate_list(value, list)
        raise ArgumentError, "must be one of #{list.join(', ')}" unless list.include?(value)

        value.to_sym
      end

      def validate_type(value, type, exception=TypeError)
        raise exception, "value must be a #{type}" unless value.is_a?(type)

        value
      end

      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
      # -= Attributes                                                                          =- #
      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

      def validate_size_attribute(value)
        if value.is_a?(Symbol) # TODO: Use respond_to #to_sym, utilize validate_list
          raise ArgumentError, "must be one of #{VALID_SIZE_SYMBOLS.join(', ')}" unless VALID_SIZE_SYMBOLS.include?(value)
        else
          value = value.to_i
          value = 0 if value < 0
        end

        value
      end

      # TODO: Color class should have a helper for this in Color#initialzie
      def validate_color_attribute(value)
        unless value.is_a?(Cura::Color)
          value = value.to_sym

          if [:black, :white, :red, :green, :blue].include?(value)
            value = Cura::Color.send(value)
          else
            raise Error::InvalidColor unless value == :inherit
          end
        end

        value
      end

      # TODO: Rename to validate_attribute_type
      def validate_offset_attribute(value, type)
        value ||= {}

        value.is_a?(type) ? value : type.new(value)
      end
    end
  end
end
