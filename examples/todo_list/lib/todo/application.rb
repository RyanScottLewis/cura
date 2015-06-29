require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'cura'

module Todo
  
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
    end

    def update
      super
    end

  end
 
end
