if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_application"
  require "cura/attributes/has_children"
  require "cura/attributes/has_coordinates"
  require "cura/attributes/has_dimensions"
  require "cura/attributes/has_events"
  
  require "cura/component/group"
end

module Cura
  
  # A window containing a drawing area.
  class Window
    
    include Attributes::HasInitialize
    include Attributes::HasAttributes
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    include Attributes::HasEvents
    
    on_event(:focus) do |event|
      update_focused_index(event)
    end
    
    on_event(:key_down) do |event|
      self.focused_index += 1 if event.name == :tab
    end
    
    def initialize(attributes={})
      @root = Component::Group.new(parent: self)
      @focused_index = 0
      
      super
    end
    
    # Update this window's components.
    #
    # @return [Window]
    def update
      @root.update
      
      self
    end
    
    # Draw this window's children.
    #
    # @return [Window]
    def draw
      application.adapter.clear
      @root.draw
      application.adapter.present
      
      self
    end
    
    # Show this window.
    #
    # @return [Window]
    def show
      self
    end
    
    # Hide this window.
    #
    # @return [Window]
    def hide
      self
    end
    
    # Return this window's parent.
    #
    # @return [Window]
    def parent # TODO: Needed?
      @application
    end
    
    # Instance inspection.
    #
    # @return [String]
    def inspect
      "#<#{self.class}:0x#{__id__.to_s(16)} application=#{@application.class}:0x#{@application.__id__.to_s(16)}>"
    end
    
    # Get root component for this window.
    #
    # @return [Component::Group]
    attr_reader :root
    
    # Set root component for this window.
    #
    # @param [Component::Group] component
    # @return [Component::Group]
    def root=(component)
      raise TypeError, "root must be a Component::Group" unless component.is_a?(Component::Group)
      
      @root.parent = nil unless @root.nil?
      @root = component
      @root.parent = self
      
      @root
    end
    
    # Root Delegates -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    
    # Get the children of this object.
    #
    # @return [<Component>]
    def children(recursive=false)
      @root.children(recursive)
    end
    
    # Add a child to this window's root component.
    #
    # @param [Component] component
    # @return [Component]
    def add_child(component)
      @root.add_child(component)
    end
    
    # Add multiple children to this window's root component.
    #
    # @param [<Component>] children
    # @return [<Component>]
    def add_children(*children)
      @root.add_children(*children)
    end
    
    # Remove a child from window's root component at the given index.
    #
    # @param [Integer] index
    # @return [Component]
    def delete_child_at(index)
      @root.delete_child_at(index)
    end
    
    # Remove a child from this window's root component.
    #
    # @param [Component] component
    # @return [Component]
    def delete_child(component)
      @root.delete_child(component)
    end
    
    # Remove all children from window's root component.
    #
    # @return [HasChildren]
    def delete_children
      @root.delete_children
    end
  
    # Determine if this window's root component has children.
    #
    # @return [Boolean]
    def children?
      @root.children?
    end
    
    # TODO: Focus controller -==-=--=-=-=-==--=-=-==--=-==--=-==-=--=-==--=-==--=-=-=-=-=-==--=
    
    # Get the index of the currently focused component.
    #
    # @return [Integer]
    attr_reader :focused_index
    
    # Set the index of the currently focused component.
    # This will send dispatch a Event::Focus instance to the object.
    #
    # @param [#to_i] value
    # @return [Integer]
    def focused_index=(value)
      @focused_index = value.to_i
      focusable_children = focusable_children_of(self)
      @focused_index %= focusable_children.length
      
      application.focus(focusable_children[@focused_index])
    end
    
    protected
    
    def update_focused_index(event)
      focusable_children = focusable_children_of(self)
      
      @focused_index = focusable_children.index(event.target)
    end
    
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
