require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'cura'

module HelloWorld
  class Application < Cura::Application
    
    on_event(:key_down) do |event|
      stop if event.key_name == :cancel # CTRL+C
    end
    
    attr_accessor :timer_start
    attr_reader :input_result_label
    
    def initialize(attributes={})
      super
      
      window = Cura::Window.new
      add_window(window)
      
      pack = Cura::Component::Pack.new( width: window.width, height: window.height, fill: true )
      window.add_child(pack)
      
      label_header = Cura::Component::Label.new( text: 'Cura', bold: true, underline: true, alignment: { horizontal: :center }, margins: { top: 1 } )
      pack.add_child(label_header)
      
      label_help = Cura::Component::Label.new( text: 'Press CTRL-C to exit', alignment: { horizontal: :center }, margins: { bottom: 1 } )
      pack.add_child(label_help)
      
      label_hello = Cura::Component::Label.new( text: 'Hello, world!', alignment: { horizontal: :center } )
      pack.add_child(label_hello)
      
      label_hello_kanji = Cura::Component::Label.new( text: '今日は', alignment: { horizontal: :center }, margins: { bottom: 1 } )
      pack.add_child(label_hello_kanji)
      
      
      input_pack = Cura::Component::Pack.new( fill: true )
      input_header_label = Cura::Component::Label.new( text: 'Type and press Enter to echo for 5 seconds:' )
      input_pack.add_child(input_header_label)
      
      input_textbox = Cura::Component::Textbox.new
      input_pack.add_child(input_textbox)
      
      #-----
      
      @timer_start = nil
      @input_result_label = Cura::Component::Label.new
      input_pack.add_child(@input_result_label)

      input_textbox.on_event(:key_down) do |event|
        if event.key_name == :enter
          application.timer_start = Time.now
          application.input_result_label.text = input_textbox.text
          clear
        end
      end
      
      #-----
      
      pack.add_child(input_pack)


      name_label = Cura::Component::Label.new( text: 'Name:' )
      pack.add_child(name_label)
      
      name_textbox = Cura::Component::Textbox.new
      pack.add_child(name_textbox)
      
      input_textbox.focus
    end
    
    def update
      super
      
      if !@timer_start.nil? && Time.now - @timer_start > 5
        @timer_start = nil
        @input_result_label.text = nil
      end
    end
  
  end
end
