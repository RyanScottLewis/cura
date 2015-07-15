if Kernel.respond_to?(:require)
  require "cura/event/mouse_down"
  require "cura/event/mouse_up"
  
  require "cura/event/middleware/base"
end

module Cura
  module Event
    module Middleware
      
      # Sets the dispatcher's target to the component underneath the cursor on mouse button events.
      class MouseFocus < Base
        
        def call(options={})
          options[:dispatcher].target = top_most_component_at(event) if options[:event].is_a?(Event::MouseDown) || options[:event].is_a?(Event::MouseUp)
        end
        
        protected
        
        # TODO: Some kind of hit tester class that initializes with a Window to get it's root element and determines
        #       if a set of coordinates are within the bounds of which component in the view tree.
        def top_most_component_at(event)
          # TODO: Focused window? Or some way of determining which window so use top_most_component_at with
          windows.first.children(true).reverse.find do |child|
            (child.absolute_x..child.absolute_x + child.width).include?(event.x) &&
              (child.absolute_y..child.absolute_y + child.width).include?(event.y)
          end
        end
        
      end
      
    end
  end
end
