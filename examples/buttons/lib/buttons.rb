if Kernel.respond_to?(:require)
  require "cura"
  # require 'cura-adapter-termbox'
  require "cura/termbox/adapter"
  # require 'cura-adapter-curses'
  # require 'cura-adapter-sdl'
  # require 'cura-adapter-sdl-ffi'
  # require 'cura-adapter-opengl'
  # require 'cura-adapter-opengl-ffi'
  # require 'cura-adapter-gosu'
end

class Buttons < Cura::Application
  
  on_event(:key_down) do |event|
    stop if event.control? && event.name == :C # CTRL+C
  end
  
  def initialize(attributes={})
    super

    window = Cura::Window.new
    add_window(window)
    
    pack = Cura::Component::Pack.new(orientation: :horizontal)
    window.add_child(pack)
    
    clear_button = Cura::Component::Label.new(text: "Clear", padding: { left: 1, right: 1 }, background: Cura::Color.white, foreground: Cura::Color.black)
    pack.add_child(clear_button)
    
    submit_button = Cura::Component::Label.new(text: "Submit", padding: { left: 1, right: 1 }, margin: { left: 1 }, background: Cura::Color.white, foreground: Cura::Color.black)
    pack.add_child(submit_button)
  end
  
end
