if Kernel.respond_to?(:require)
  require "cura/error/base"
end

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
