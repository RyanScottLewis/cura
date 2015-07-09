module TodoList
  
  class Header < Cura::Component::Pack
    
    attr_reader :create_list_textbox
    
    def initialize(attributes={})
      attributes = { orientation: :horizontal }.merge(attributes)
      
      super(attributes)
      
      add_children(
        Cura::Component::Label.new( text: 'Todo', bold: true, margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-C to exit', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-E to edit item', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-D to delete item', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-F to move focus forwards', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-B to move focus backwards', margin: { right: 3 } ),
      )
    end
    
  end
  
end
