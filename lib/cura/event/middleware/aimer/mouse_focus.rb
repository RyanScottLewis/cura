if Kernel.respond_to?(:require)
  require "cura/event/mouse_down"
  require "cura/event/mouse_up"
  
  require "cura/event/middleware/aimer/base"
end

module Cura
  module Event
    module Middleware
      module Aimer
        
        # Sets the dispatcher's target to the component underneath the cursor on mouse button events.
        class MouseFocus < Base
          
          protected
          
          def should_aim?(options={})
            options[:event].is_a?(Event::MouseDown)
          end
          
          def set_target(options={})
            component = nearest_focusable_ancestor(top_most_component_at(options))
            
            options[:dispatcher].target = component unless options[:dispatcher].target == component
          end
          
          # TODO: Some kind of hit tester class that initializes with a Window to get it's root element and determines
          #       if a set of coordinates are within the bounds of which component in the view tree.
          def top_most_component_at(options={})
            # TODO: Focused window? Or some way of determining which window so use top_most_component_at with
            window = options[:dispatcher].application.windows.first # TODO: Should be getting the screen coordinates from the event, not relevent to the window
            window.children(true).reverse.find { |child| child.contains_coordinates?(x: options[:event].x, y: options[:event].y) }
          end
          
          def nearest_focusable_ancestor(component)
            return nil unless component.respond_to?(:focusable?)
            return component if component.focusable?
            return nil unless component.respond_to?(:parent)
            
            nearest_focusable_ancestor(component.parent)
          end
          
        end
        
      end
    end
  end
end
