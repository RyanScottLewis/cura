require "cura/event/middleware/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    module Middleware
      module Aimer
        # The base class for event middleware which set's a target, if needed.
        class Base
          # Call this middleware.
          #
          # @param [#to_h] options
          # @option options [Event::Dispatcher] :dispatcher
          # @option options [Event::Base] :event
          # @option options [Attributes::HasEvents] :target The optional target of the event.
          def call(options={})
            set_target(options) if should_aim?(options)
          end

          protected

          def should_aim?(options={})
            options[:event].target.nil?
          end

          def set_target(_options={})
            # Does nothing on purpose
          end
        end
      end
    end
  end
end
