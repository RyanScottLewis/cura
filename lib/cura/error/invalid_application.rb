if Kernel.respond_to?(:require)
  require 'cura/error/base'
end

module Cura
  module Error
    
    class InvalidApplication < Base
      
      def to_s
        'application must nil or be a Cura::Application'
      end
      
    end
    
  end
end
