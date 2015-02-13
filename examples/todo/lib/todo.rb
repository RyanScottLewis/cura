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
      choose_adapter
      run_with_adapter
    end
    
    protected
    
    def choose_adapter
      adapter_names = Cura::Adapter.all.collect(&:name)
      
      loop do
        puts "Choose one or type 'exit': #{ adapter_names.join(', ') }"
        print '> '
        
        adapter = gets.downcase.strip.to_sym
  
        exit if adapter == 'exit'
        retry unless adapter_names.include?( adapter )
        
        adapter
      end
    end
    
    def run_with_adapter
      Application.run( adapter: adapter )
    end
    
  end
  
end
