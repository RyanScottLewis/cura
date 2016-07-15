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
        raise(exception, "value must be a #{type}") unless value.is_a?(type)

        value
      end

      def validate_integer(value, options={})
        options = options.to_h

        value = value.to_i

        options[:minimum] = options.delete(:min) if options.key?(:min)
        options[:maximum] = options.delete(:max) if options.key?(:max)

        if options.key?(:minimum)
          options[:minimum] = options[:minimum].to_i

          value = options[:minimum] if value < options[:minimum]
        end

        if options.key?(:maximum)
          options[:maximum] = options[:maximum].to_i

          value = options[:maximum] if value < options[:maximum]
        end

        value
      end

      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #
      # -= Attributes                                                                          =- #
      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- #

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
    end
  end
end
