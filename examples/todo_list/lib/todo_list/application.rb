require 'cura'

module TodoList
  
  class Sidebar < Cura::Component::Pack
    
    attr_reader :create_list_textbox
    
    def initialize(attributes={})
      attributes = { fill: true }.merge(attributes)
      
      super(attributes)
      
      header_pack = Cura::Component::Pack.new( orientation: :horizontal )
      add_child(header_pack)
      
      @create_list_textbox = Cura::Component::Textbox.new( width: (width/3).floor*2, margins: { right: 1 } )
      @create_list_textbox.on_event(:key_down, self) { |event, sidebar| sidebar.create_list if event.name == :enter }
      header_pack.add_child(@create_list_textbox)
      
      @create_list_button = Cura::Component::Button.new( width: (width/3).floor, text: 'Create', padding: { left: 1, right: 1 } )
      @create_list_button.on_event(:click, self) { |event, sidebar| sidebar.create_list }
      header_pack.add_child(@create_list_button)
      
      @listbox = Cura::Component::Listbox.new( width: @width )
      @listbox.on_event(:key_down, self) do |event, sidebar|
        if event.control? && event.name == :D
          List.find( name: selected_child.text ).destroy
          sidebar.fill_listbox
          self.selected_index = selected_index - 1
        end
        
        selected_child.focus if event.target == self && event.control? && event.name == :E
      end
      
      add_child(@listbox)
      
      fill_listbox
    end
    
    def create_list
      name = @create_list_textbox.text
      
      List.create( name: name )
      
      fill_listbox
      
      @create_list_textbox.clear
      @create_list_textbox.focus
    end
    
    def fill_listbox
      @listbox.delete_children
      
      List.all.each do |list|
        list_textbox = Cura::Component::Textbox.new( text: list.name, background: Cura::Color.black, foreground: Cura::Color.white )
        list_textbox.on_event(:key_down, @listbox) do |event, listbox|
          if event.name == :enter
            list.name = text
            
            list.save
            
            listbox.focus
          end
        end
        
        @listbox.add_child( list_textbox )
      end
    end
    
  end
  
end

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
      
      main_pack = Cura::Component::Pack.new( width: window.width, height: window.height, orientation: :horizontal, fill: true )
      window.add_child(main_pack)
      
      sidebar = Sidebar.new( width: 20 )
      main_pack.add_child(sidebar)
      
      sidebar.create_list_textbox.focus
      
    end
  
  end
  
end