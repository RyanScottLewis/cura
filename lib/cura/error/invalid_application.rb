if Kernel.respond_to?(:require)
  require "cura/error/base"
end

module Cura
  module Error
    
    # Raised when an application is invalid.
    class InvalidApplication < Base
      
      def to_s
        "must nil or be a Cura::Application"
      end
      
    end
    
  end
end
