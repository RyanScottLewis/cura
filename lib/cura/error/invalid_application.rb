require "cura/error/base" if Kernel.respond_to?(:require)

module Cura
  module Error
    # Raised when an application is invalid.
    class InvalidApplication < Base # TODO: REMOVE
      def to_s
        "must nil or be a Cura::Application"
      end
    end
  end
end
