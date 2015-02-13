require 'cura'
# require 'cura-adapter-termbox'
require 'cura-adapter-termbox-ffi'
# require 'cura-adapter-curses'
# require 'cura-adapter-sdl'
# require 'cura-adapter-sdl-ffi'
# require 'cura-adapter-opengl'
# require 'cura-adapter-opengl-ffi'
# require 'cura-adapter-gosu'

module Todo
  
  class << self
    
    def run
      adapter = choose_adapter
      
      Application.run( adapter: adapter )
    end
    
    protected
    
    def choose_adapter
      adapter_names = Cura::Adapter.all.collect(&:name)
      adapter = nil
      
      loop do
        puts "\nChoose one or type 'exit': #{ adapter_names.join(', ') }"
        print '> '
        
        adapter = gets.downcase.strip.to_sym
  
        exit if adapter == :exit
        break if adapter_names.include?( adapter )
      end
      
      adapter
    end
    
  end
  
end
