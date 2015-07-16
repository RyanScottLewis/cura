if Kernel.respond_to?(:require)
  require "cura/event/middleware/aimer/base"
end

module Cura
  module Event
    module Middleware
      module Aimer
        
        # Sets the event's target to the component passed by an optional :target option.
        class TargetOption < Base
          
          # Call this middleware.
          #
          # @param [#to_h] options
          # @option options [Event::Dispatcher] :dispatcher
          # @option options [Event::Base] :event
          # @option options [Attributes::HasEvents] :target The optional target of the event.
          def call(options={})
            super # Only here for documentation
          end
          
          protected
          
          def should_aim?(options={})
            options.key?(:target)
          end
          
          def set_target(options={})
            options[:event].target = options[:target]
          end
          
        end
        
      end
    end
  end
end
