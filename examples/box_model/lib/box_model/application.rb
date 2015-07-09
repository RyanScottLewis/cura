require 'cura'

module BoxModel
  
  class Application < Cura::Application
    
    on_event(:key_down) { |event| stop if event.control? && event.name == :C }
  
    def initialize(attributes={})
      super
  
      window = Cura::Window.new
      add_window( window )
      
      group = Cura::Component::Group.new( background: Cura::Color.red, margin: 1, padding: 1 )
      window.add_child( group )
      
      label = Cura::Component::Label.new( text: 'Hello, world!', background: Cura::Color.blue, padding: 1 )
      group.add_child( label )
    end
  
  end
  
end
