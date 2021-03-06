require "cura/event/middleware/aimer/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    module Middleware
      module Aimer
        # Sets the event's target to the component passed by an optional :target option.
        class TargetOption < Base
          # @method call
          # Call this middleware.
          #
          # @param [#to_h] options
          # @option options [Event::Dispatcher] :dispatcher
          # @option options [Event::Base] :event
          # @option options [Attributes::HasEvents] :target The optional target of the event.

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
