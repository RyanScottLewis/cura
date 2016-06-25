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
          # TODO: !!!! Refactor
          return nil if options[:event].nil?
          return nil if options[:event].target.nil?
          return nil if !options[:event].target.is_a?(Application) && options[:event].target.application.nil? # TODO: Check if orphaned, maybe log this?

          options[:dispatch_queue] << options[:event]
        end
      end
    end
  end
end
