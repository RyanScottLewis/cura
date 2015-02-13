module Todo
  module View
    
    class Index < Cura::Component::Pack
      
      def initialize(attributes={})
        super
        
        create_button = Button.new( text: 'Create' )
        create_button.on_event(:clicked) { |event| window.views.show(:create) }
        add_child(create_button)
      
        @items = Listbox.new
        add_child(@items)
      end
      
    end
    
  end
end
