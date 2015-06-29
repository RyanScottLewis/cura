if Kernel.respond_to?(:require)
  require 'cura/error/base'
end

module Cura
  module Error
    
    class InvalidAdapter < Base
      
      def to_s
        'The adapter is invalid.'
      end
      
    end
    
  end
end
