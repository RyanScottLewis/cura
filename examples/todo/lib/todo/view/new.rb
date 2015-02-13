module Todo
  module View
    
    class New < Cura::Component::Pack
      
      on_event(:focus) { @textbox.clear }
      
      def initialize(attributes={})
        super
        
        @textbox = Textbox.new
        add_child(@textbox)
        
        buttons = Pack.new
        
        create_button = Button.new( text: 'Create' )
        create_button.on_event(:clicked) do
          todo_item = Models::TodoItem.new( value: parent.parent.textbox.text )
          
          # if todo_item.valid?
          #   todo_item.save
          #
          #   window.views.show(:index)
          # else
          #   # todo_item.errors.each do .........
          # end
          
          window.views.show(:index)
        end
        buttons.add_child(create_button)
        
        cancel_button = Button.new( text: 'Cancel' )
        cancel_button.on_event(:clicked) do
          parent.parent.textbox.clear
          window.views.show(:index)
        end
        buttons.add_child(cancel_button)
        
        add_child(buttons)
      end
      
      attr_reader :textbox
      
    end
    
  end
end
