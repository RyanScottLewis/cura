require "todo_list/component/list_item"

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

        @create_list_item_textbox = Cura::Component::Textbox.new(width: width - 21, margin: { right: 1 })
        @create_list_item_textbox.on_event(:key_down, self) { |event, model_list| model_list.create_list_item if event.name == :enter }
        create_form_pack.add_child(@create_list_item_textbox)

        @create_list_item_button = Cura::Component::Button.new(text: "Create List Item", padding: { left: 1, right: 1 })
        @create_list_item_button.on_event(:click, self) { |_, model_list| model_list.create_list_item }
        create_form_pack.add_child(@create_list_item_button)

        @listbox_header_label = Cura::Component::Label.new(text: " " * width, bold: true, underline: true, margin: { top: 1 })
        add_child(@listbox_header_label)

        @listbox = Cura::Component::Listbox.new(width: @width)

        @listbox.on_event(:key_down, self) do |event, model_list|
          if event.target == self
            if event.control? && event.name == :D && !selected_object.nil?
              selected_object.list.remove_list_item(selected_object) # Sequel?! Why do I have to do this with associations??!
              selected_object.destroy

              previous_selected_index = @selected_index
              model_list.fill_listbox
              self.selected_index = [previous_selected_index, count - 1].min
            end

            if event.control? && event.name == :E
              selected_child.focusable = true
              selected_child.focus
            end

            if event.name == :enter
              selected_object.completed = !selected_object.completed
              selected_object.save
            end
          end
        end

        add_child(@listbox)
      end

      def create_list_item
        text = @create_list_item_textbox.text

        @list.add_list_item(text: text)

        fill_listbox

        @create_list_item_textbox.clear
        @create_list_item_textbox.focus
      end

      def fill_listbox
        @listbox.delete_children

        return nil if @list.nil?

        @list.list_items.each do |list_item|
          list_item_component = Component::ListItem.new(listbox: @listbox, model: list_item, width: @listbox.width)

          @listbox.add_child(list_item_component, object: list_item)
        end unless @list.nil?
      end

      def list=(list)
        @list = list

        if @list.nil?
          @listbox_header_label.text = " " * width
        else
          @listbox_header_label.text = @list.text + " " * (width - @list.text.length) unless @list.text.length >= width
        end

        fill_listbox
      end

    end

  end
end
