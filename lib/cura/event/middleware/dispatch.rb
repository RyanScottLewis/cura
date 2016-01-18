module Cura
  module Event
    module Middleware
      # Dispatches the event.
      class Dispatch < Base
        # Dispatch the event.
        #
        # @param [#to_h] options
        # @option options [Event::Base] :event
        def call(options={})
          options[:dispatch_queue] << options[:event]
        end
      end
    end
  end
end
