require 'cura'

require 'todo_list/header'
require 'todo_list/sidebar'
require 'todo_list/list_items'

module TodoList
  
  class Application < Cura::Application
    
    on_event(:key_down) do |event|
      stop if event.control? && event.name == :C # CTRL+C
    end
    
    attr_reader :list_items
    
    def initialize(attributes={})
      super
  
      window = Cura::Window.new
      
      add_window(window)
      
      window.on_event(:key_down) do |event|
        self.focused_index += 1 if event.control? && event.name == :F
        self.focused_index -= 1 if event.control? && event.name == :B
      end
      
      main_pack = Cura::Component::Pack.new( width: window.width, height: window.height, fill: true )
      window.add_child(main_pack)
      
      header = Header.new
      main_pack.add_child(header)
      
      middle_pack = Cura::Component::Pack.new( height: window.height-1, orientation: :horizontal, fill: true )
      main_pack.add_child(middle_pack)
      
      sidebar = Sidebar.new( width: 30, padding: 1 )
      middle_pack.add_child(sidebar)
      
      @list_items = ListItems.new( width: window.width - 36, padding: 1 )
      middle_pack.add_child(@list_items)
      
      @list_items.list = sidebar.listbox.selected_object if sidebar.listbox.children?
      
      sidebar.create_list_textbox.focus
    end
  
  end
  
end
