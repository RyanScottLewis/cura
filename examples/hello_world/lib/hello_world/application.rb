module HelloWorld
  class Application < Cura::Application
  
    def initialize
      super
      
      window = Window.new
      
      label_header = Component::Label.new( text: 'Cura', bold: true, alignment: { horizontal: :center }, margins: { top: 1, bottom: 1 } )
      window.add_child(label_header)
      
      label_hello = Component::Label.new( text: 'Hello, world!', alignment: { horizontal: :center } )
      window.add_child(label_hello)
      
      add_window(window)
    
      window.show
    end
  
  end
end
