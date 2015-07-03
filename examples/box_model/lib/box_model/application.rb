require 'cura'

module BoxModel
  
  class Application < Cura::Application
    
    on_event(:key_down) { |event| stop if event.control? && event.name == :C }
  
    def initialize(attributes={})
      super
  
      window = Cura::Window.new
      add_window(window)
      
      label = Cura::Component::Label.new( text: 'Hello, world!', margin: :auto )
    end
  
  end
  
end