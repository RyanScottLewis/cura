module TodoList
  
  class Header < Cura::Component::Pack
    
    attr_reader :create_list_textbox
    
    def initialize(attributes={})
      attributes = { orientation: :horizontal }.merge(attributes)
      
      super(attributes)
      
      add_children(
        Cura::Component::Label.new( text: 'Todo', bold: true, margin: { right: 20 } ),
        Cura::Component::Label.new( text: '^-C to exit', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-E to edit list item', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-D to delete list item' )
      )
    end
    
  end
  
end
