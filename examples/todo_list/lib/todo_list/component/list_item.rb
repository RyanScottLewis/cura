require "todo_list/component/list"

module TodoList
  module Component
    
    class ListItem < List
      
      def update
        @label.text = model.completed ? "✓" : "✘"
      end
      
      protected
      
      def setup_components
        setup_label
        setup_textbox
      end
      
      def setup_label
        @label = Cura::Component::Label.new(margin: { right: 1 })
        
        add_child(@label)
      end
      
    end
    
  end
end
