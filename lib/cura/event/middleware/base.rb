module Cura
  module Event
    module Middleware
      # The base class for event middleware.
      class Base
        # Call this middleware.
        #
        # @param [#to_h] options
        # @option options [Event::Dispatcher] :dispatcher
        # @option options [Event::Base] :event
        def call(_options={})
          # Does nothing on purpose
        end
      end
    end
  end
end
