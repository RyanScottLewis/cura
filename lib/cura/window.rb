if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_application'
  require 'cura/attributes/has_children'
  require 'cura/attributes/has_coordinates'
  require 'cura/attributes/has_dimensions'
  require 'cura/attributes/has_events'
end

module Cura
  
  # A window containing a drawing area.
  class Window
    
    include Attributes::HasInitialize
    include Attributes::HasApplication
    include Attributes::HasChildren
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    include Attributes::HasEvents
    
    # Update this window's components.
    # 
    # @return [Window]
    def update
      update_children
      
      self
    end
    
    # Draw this window's children.
    # 
    # @return [Window]
    def draw
      application.adapter.clear
      
      draw_children
      # application.cursor.draw # TODO
      
      application.adapter.present
      
      @redraw = false
      
      self
    end
    
    # Queue all children for drawing during the next loop cycle.
    # 
    # @return [Window]
    def redraw
      @redraw = true
      
      self
    end
    
    # Get whether all children will redraw in the next loop cycle.
    # 
    # @return [Boolean]
    def redraw?
      @redraw == true
    end
    
    # Show this window.
    # 
    # @return [Window]
    def show
      
    end
    
    # Hide this window.
    # 
    # @return [Window]
    def hide
      
    end
    
    # Add a child to this window.
    # 
    # @param [Component] component
    # @return [Component]
    def add_child(component)
      component = super
      
      component.parent = self
      
      component
    end
      
    # Remove a child from this window's children at the given index.
    # 
    # @param [Integer] index
    # @return [Component]
    def delete_child_at(index)
      component = super
      
      component.parent = nil
      
      component
    end
    
    # Return this window's parent.
    # 
    # @return [Window]
    def parent
      @application
    end
    
  end
  
end
