module Cura
  module Event
    module Middleware
      # Adds the event to the dispatch queue.
      # Should be the very last middleware in the chain.
      class Dispatch < Base
        # Add the event to the dispatch queue.
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
