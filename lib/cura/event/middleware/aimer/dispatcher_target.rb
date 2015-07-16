if Kernel.respond_to?(:require)
  require "cura/event/middleware/aimer/base"
end

module Cura
  module Event
    module Middleware
      module Aimer
        
        # Sets the event's target to the dispatcher's target, if it isn't already set.
        class DispatcherTarget < Base
          
          protected
          
          def set_target(options={})
            options[:event].target ||= options[:dispatcher].target
          end
          
        end
        
      end
    end
  end
end
