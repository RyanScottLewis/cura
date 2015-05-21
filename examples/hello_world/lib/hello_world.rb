require 'cura'
# require 'cura-adapter-termbox'
require 'cura/termbox_ffi/adapter'
# require 'cura-adapter-curses'
# require 'cura-adapter-sdl'
# require 'cura-adapter-sdl-ffi'
# require 'cura-adapter-opengl'
# require 'cura-adapter-opengl-ffi'
# require 'cura-adapter-gosu'

require 'hello_world/application'

module HelloWorld
  
  class << self
    
    def run
      # adapter = choose_adapter
      # 
      # Application.run( adapter: adapter )
      Application.run( adapter: Cura::TermboxFFI::Adapter.new )
    end
    
    protected
    
    def choose_adapter
      adapters = Cura::Adapter.all
      adapter = nil
      index = -1
      
      loop do
        adapters.each_with_index do |adapter, index|
          puts "#{index}. #{adapter}"
        end
        
        puts "\nChoose adapter or type 'exit'"
        print '> '
        
        answer = gets.downcase.strip
  
        exit if answer == 'exit'
        
        index = answer.to_i
        
        break if index < adapters.length && index >= 0
      end
      
      adapters[index]
    end
    
  end
  
end
