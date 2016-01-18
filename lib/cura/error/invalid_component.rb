require "cura/error/base" if Kernel.respond_to?(:require)

module Cura
  module Error
    # Raised when a component is invalid.
    class InvalidComponent < Base
      def to_s
        "must be a Cura::Component::Base"
      end
    end
  end
end
