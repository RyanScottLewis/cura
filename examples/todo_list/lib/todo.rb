require 'cura'
# require 'cura-adapter-termbox'
require 'cura/termbox_ffi/adapter'
# require 'cura-adapter-curses'
# require 'cura-adapter-sdl'
# require 'cura-adapter-sdl-ffi'
# require 'cura-adapter-opengl'
# require 'cura-adapter-opengl-ffi'
# require 'cura-adapter-gosu'

require 'todo/application'

module Todo
  
  class << self
    
    def run
      Application.run( adapter: Cura::TermboxFFI::Adapter.new )
    end
    
  end
  
end
