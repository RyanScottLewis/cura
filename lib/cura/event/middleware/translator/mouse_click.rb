if Kernel.respond_to?(:require)
  require "cura/event/mouse_button"
  require "cura/event/middleware/translator/base"
end

module Cura
  module Event
    module Middleware
      module Translator
        
        # Translates MouseDown and MouseUp events into a MouseClick event.
        class MouseClick < Base
          
          def initialize
            @last_mouse_down_at = Time.now
          end
          
          # Call this middleware.
          #
          # @param [#to_h] options
          # @option options [Event::Dispatcher] :dispatcher
          # @option options [Event::Base] :event
          def call(options={})
            event = options[:event]
            
            return unless event.is_a?(Event::Mouse)
            
            if event.down?
              @last_mouse_down_at = event.created_at
              @last_target = event.target
            elsif event.up? && event.created_at > @last_mouse_down_at && @last_target.respond_to?(:contains_coordinates) && @last_target.contains_coordinates?(x: event.x, y: event.y)
              @last_mouse_down_at = nil
              @last_target = nil
              
              options[:dispatch_queue] << Event.new_from_name(:mouse_button, state: :click, target: event.target, x: event.x, y: event.y) # TODO: Left? Right? Termbox can't tell..
            end
          end
          
        end
        
      end
    end
  end
end
