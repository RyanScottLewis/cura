if Kernel.respond_to?(:require)
  require "cura/attributes/has_initialize"
  require "cura/attributes/has_application"
  require "cura/attributes/has_children"
  require "cura/attributes/has_coordinates"
  require "cura/attributes/has_dimensions"
  require "cura/attributes/has_events"
  require "cura/attributes/has_root"
end

module Cura
  
  # A window containing a drawing area.
  class Window
    
    include Attributes::HasInitialize
    include Attributes::HasApplication
    include Attributes::HasCoordinates
    include Attributes::HasDimensions
    include Attributes::HasEvents
    include Attributes::HasRoot
    
    on_event(:focus) do |event|
      update_focused_index(event.target)
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
      self # TODO
    end
    
    # Hide this window.
    #
    # @return [Window]
    def hide
      self # TODO
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
      focusable_children = focusable_children_of(@root)
      @focused_index %= focusable_children.length
      
      application.focus(focusable_children[@focused_index])
    end
    
    protected
    
    def update_focused_index(component)
      focusable_children = focusable_children_of(@root)
      
      @focused_index = focusable_children.index(component)
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
