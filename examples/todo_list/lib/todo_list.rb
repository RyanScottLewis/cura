require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'cura'
require 'yaml'

class TodoList < Cura::Application
  
  class << self
    
    def data_path
      @data_path ||= Pathname.new(__FILE__).join( '..', '..', 'data.yml' )
    end
    
    def load_data
      @data = data_path.exist? ? YAML.load_file( data_path.to_s ) : []
    end
    
    def save_data
      data_path.open('w+') { |file| file.write( @data.to_yaml ) }
    end
    
    def run
      load_data
      
      super
    end
    
  end

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
    
    main_pack = Cura::Component::Pack.new( width: window.width, height: window.height, fill: true )
    window.add_child(main_pack)
        #
    # sidebar_pack = Cura::Component::Pack.new( fill: true )
    # main_pack.add_child(sidebar_pack)
    
    @lists_listbox = Cura::Component::Listbox.new( width: 20, background: Cura::Color.red )
    @lists_listbox.on_event(:key_down) { |event| delete_child(selected_child) if event.control? && event.name == :D }

    main_pack.add_child(@lists_listbox)
  end

  def update
    super
  end

end
