require "pry"

require "cura"

require "todo_list/component/header"
require "todo_list/component/lists"
require "todo_list/component/list_items"

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
        @focus_controller.index += 1 if event.control? && event.name == :F
        @focus_controller.index -= 1 if event.control? && event.name == :B
        if event.control? && event.name == :P
          application.stop!
          pry
        end
      end

      #-

      window.root = Cura::Component::Pack.new(width: window.width, height: window.height, fill: true)

      header = Component::Header.new
      window.add_child(header)

      middle_pack = Cura::Component::Pack.new(height: window.height - 1, orientation: :horizontal, fill: true)
      window.add_child(middle_pack)

      sidebar = Component::Lists.new(width: 30, padding: 1)
      middle_pack.add_child(sidebar)

      @list_items = Component::ListItems.new(width: window.width - 30 - 4, padding: 1)
      middle_pack.add_child(@list_items) # , expand: true, fill: true) # TODO

      #-

      @list_items.list = sidebar.listbox.selected_object if sidebar.listbox.children?

      sidebar.create_list_textbox.focus
    end

  end

end
