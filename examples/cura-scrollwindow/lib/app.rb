require "cura"
require "cura/termbox/adapter"
require "faker"
require "pry"

class ScrollWindowApp < Cura::Application
  on_event(:key_down) do |event|
    stop if event.control? && event.name == :C # CTRL+C

    @listbox.add_child(:label, text: Faker::Hipster.sentence)
  end

  def initialize(attributes={})
    super

    window = Cura::Window.new
    add_window(window)

    window.root = Cura::Component::Pack.new(width: window.width, height: window.height, fill: true)

    @listbox = window.add_child(:listbox, height: window.height-1, background: Cura::Color.red)

    line_pack = window.add_child(:pack, orientation: :horizontal)

    @prompt = line_pack.add_child(:label, text: ">", margin: { right: 1 })
    @input = line_pack.add_child(:textbox, width: window.width - @prompt.width)

    @input.focus
  end
end



require "ruby-prof"

RubyProf.start

app = ScrollWindowApp.new

Thread.new do
  sleep 5

  letters = ("A".."Z").to_a + ("a".."z").to_a
  letters.each do |letter|
    app.dispatch_event(:key_down, name: letter)
    sleep 0.25
  end
  app.stop
end
app.run


result = RubyProf.stop

path = Pathname.new(__FILE__).join("..", "..", "doc", "coverage").expand_path
path.mkpath

printer = RubyProf::CallStackPrinter.new(result)
path.join("call_stack.html").open("w+") { |file| printer.print(file) }

printer = RubyProf::GraphHtmlPrinter.new(result)
path.join("graph.html").open("w+") { |file| printer.print(file) }
