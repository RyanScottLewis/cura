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
    
    on_event(:focus) do |event|
      focusable_children = focusable_children_of(self)
      
      @focused_index = focusable_children.index( event.target )
    end
    
    on_event(:key_down) do |event|
      self.focused_index += 1 if event.name == :tab
    end
    
    def initialize(attributes={})
      @focused_index = 0
      
      super
    end
    
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
      
      application.adapter.present
      
      self
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
    
    # Instance inspection.
    # 
    # @return [String]
    def inspect
      "#<#{self.class}:0x#{__id__.to_s(16)} application=#{@application.class}:0x#{@application.__id__.to_s(16)}>"
    end
    
    attr_reader :focused_index
    
    def focused_index=(value)
      focusable_children = focusable_children_of(self)

      @focused_index = value.to_i
      @focused_index = @focused_index % focusable_children.length

      application.focus( focusable_children[@focused_index] )
    end
    
    protected
    
    # Recursively find all children which are focusable.
    def focusable_children_of(component)
      result = []
      
      component.children.each do |child|
        result << child if child.focusable?
        result << focusable_children_of(child) if child.respond_to?(:children)
      end
      
      result.flatten
    end
    
  end
  
end
