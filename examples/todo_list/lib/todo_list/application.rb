require 'cura'

require 'todo_list/sidebar'

module TodoList
  
  class Application < Cura::Application
    
    on_event(:key_down) do |event|
      stop if event.control? && event.name == :C # CTRL+C
    end
  
    def initialize(attributes={})
      super
  
      window = Cura::Window.new
      
      add_window(window)
      
      window.on_event(:key_down) do |event|
        self.focused_index += 1 if event.control? && event.name == :F
        self.focused_index -= 1 if event.control? && event.name == :B
      end
      
      main_pack = Cura::Component::Pack.new
      window.add_child(main_pack)
      
      header_pack = Cura::Component::Pack.new( orientation: :horizontal )
      main_pack.add_child(header_pack)
      
      header_pack.add_children(
        Cura::Component::Label.new( text: 'Todo', bold: true, margin: { right: 5 } ),
        Cura::Component::Label.new( text: '^-C to exit', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-E to edit list item', margin: { right: 3 } ),
        Cura::Component::Label.new( text: '^-D to delete list item' )
      )
      
      middle_pack = Cura::Component::Pack.new( orientation: :horizontal, fill: true )
      main_pack.add_child(middle_pack)
      
      sidebar = Sidebar.new( width: 20, background: Cura::Color.blue )
      middle_pack.add_child(sidebar)
      
      
      LOGGER.debug( ?- * 80 )
      LOGGER.debug( "main_pack.height = #{ main_pack.height }" )
      LOGGER.debug( main_pack.inspect )
      LOGGER.debug( "header_pack.height = #{ header_pack.height }" )
      LOGGER.debug( header_pack.inspect )
      LOGGER.debug( header_pack.children.first.inspect )
      LOGGER.debug( "middle_pack.height = #{ middle_pack.height }" )
      LOGGER.debug( middle_pack.inspect )
      LOGGER.debug( middle_pack.children.first.inspect )
      LOGGER.debug( middle_pack.children.first.create_list_textbox.inspect )
      LOGGER.debug( middle_pack.children.first.create_list_textbox.ancestors.inspect )
      LOGGER.debug( ?- * 80 )
      
      
      sidebar.create_list_textbox.focus
    end
  
  end
  
end