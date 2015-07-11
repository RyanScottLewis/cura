if Kernel.respond_to?(:require)
  require 'cura/error/base'
end

module Cura
  module Error
    
    class InvalidComponent < Base
      
      def to_s
        'must be a Cura::Component::Base'
      end
      
    end
    
  end
end
