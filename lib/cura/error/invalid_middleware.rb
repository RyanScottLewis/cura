require "cura/error/base" if Kernel.respond_to?(:require)

module Cura
  module Error
    # Raised when middleware is invalid.
    class InvalidMiddleware < Base
      def to_s
        "must respond to #call."
      end
    end
  end
end
