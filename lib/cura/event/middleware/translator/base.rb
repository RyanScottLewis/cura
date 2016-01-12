if Kernel.respond_to?(:require)
  require "cura/event/middleware/base"
end

module Cura
  module Event
    module Middleware
      module Translator
        
        # The base class for event middleware which detects multiple events and dispatches a new one when found.
        class Base
          
          # Call this middleware.
          #
          # @param [#to_h] options
          # @option options [Event::Dispatcher] :dispatcher
          # @option options [Event::Base] :event
          def call(options={})
            translate_event(options) if should_translate?(options)
          end
          
          protected
          
          def should_translate?(_options={})
            false
          end
          
          def translate_event(_options={})
            # Does nothing on purpose
          end
          
        end
        
      end
    end
  end
end
