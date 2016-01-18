require "cura/error/base" if Kernel.respond_to?(:require)

module Cura
  module Error
    # Raised when a color is invalid.
    class InvalidColor < Base
      def to_s
        "must be a Cura::Color or :inherit"
      end
    end
  end
end
