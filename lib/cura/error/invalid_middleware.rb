if Kernel.respond_to?(:require)
  require "cura/error/base"
end

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
