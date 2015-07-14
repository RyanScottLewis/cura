module TodoList
  module Component
    
    class ListItems < Cura::Component::Pack
      
      attr_reader :create_list_item_textbox
      attr_reader :listbox
      attr_reader :list
      
      def initialize(attributes={})
        attributes = { fill: true, padding: { top: 1, bottom: 1 } }.merge(attributes)
        
        super(attributes)
        
        create_form_pack = Cura::Component::Pack.new(orientation: :horizontal)
        add_child(create_form_pack)
        
        @create_list_item_textbox = Cura::Component::Textbox.new(width: width - 21, padding: { left: 1, right: 1 }, margin: { right: 1 })
        @create_list_item_textbox.on_event(:key_down, self) { |event, model_list| model_list.create_list_item if event.name == :enter }
        create_form_pack.add_child(@create_list_item_textbox)
        
        @create_list_item_button = Cura::Component::Button.new(text: "Create List Item", padding: { left: 1, right: 1 })
        @create_list_item_button.on_event(:click, self) { |_event| model_list.create_list_item }
        create_form_pack.add_child(@create_list_item_button)
        
        @listbox_header_label = Cura::Component::Label.new(text: " " * width, bold: true, underline: true, margin: { top: 1 })
        add_child(@listbox_header_label)
        
        @listbox = Cura::Component::Listbox.new(width: @width)
        
        @listbox.on_event(:key_down, self) do |event, model_list|
          if event.target == self && event.control? && event.name == :D && !selected_object.nil?
            selected_object.destroy

            previous_selected_index = @selected_index
            model_list.fill_listbox
            self.selected_index = [previous_selected_index, count - 1].min
          end
          
          if event.target == self && event.control? && event.name == :E
            selected_child.focusable = true
            selected_child.focus
          end
        end
        
        add_child(@listbox)
        
        
      end
      
      def create_list_item
        text = @create_list_item_textbox.text
        
        Model::ListItem.create(list_id: @list.id, text: text)
        
        fill_listbox
        
        @create_list_item_textbox.clear
        @create_list_item_textbox.focus
      end
      
      def fill_listbox
        @listbox.delete_children
        
        return nil if @list.nil?
        
        @list.list_items.each do |list_item|
          list_item_textbox = Cura::Component::Textbox.new(text: list_item.text, width: @listbox.width, background: :inherit, foreground: Cura::Color.white, focusable: false)
          list_item_textbox.on_event(:key_down, @listbox) do |event, listbox|
            if event.name == :enter
              list_item.text = text
              
              list_item.save
              
              self.focusable = false
              listbox.focus
            end
          end
          
          @listbox.add_child(list_item_textbox, list_item)
        end
      end
      
      def list=(list)
        @list = list
        @listbox_header_label.text = @list.name
        @listbox_header_label.text << " " * (width - @list.name.length) unless @list.name.length >= width
        
        fill_listbox
      end
      
    end
    
  end
end
