require "cura/error/base" if Kernel.respond_to?(:require)

module Cura
  module Error
    # Raised when an adapter is invalid.
    class InvalidAdapter < Base
      def to_s
        "The adapter is invalid." # TODO: Better message
      end
    end
  end
end
