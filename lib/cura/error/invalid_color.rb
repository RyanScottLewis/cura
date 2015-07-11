if Kernel.respond_to?(:require)
  require 'cura/error/base'
end

module Cura
  module Error
    
    class InvalidApplication < Base
      
      def to_s
        'foreground must be a Cura::Color or :inherit'
      end
      
    end
    
  end
end
