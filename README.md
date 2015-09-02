# Cura

A library written in pure Ruby for building user interfaces.

Cura provides:

* Component system
* * Tree hierarchy
* * Box model layouts
* Event system
* * Dispatching
* * Middleware (aiming & translating)
* * Handling
* * Delegation
* Adapter system

## Install

### Bundler: `gem 'cura'`

### RubyGems: `gem install cura`

## Adapters

### Ruby

Used for its libraries.

**Text-based User Interface (TUI)**

* [Termbox][ruby-termbox]
* [Termbox FFI][ruby-termbox-ffi]
* [Curses][ruby-curses]

**Graphical User Interface (GUI)**

* [OpenGL][ruby-opengl]
* [OpenGL FFI][ruby-opengl-ffi]
* [SDL][ruby-sdl]
* [SDL FFI][ruby-sdl-ffi]
* [Gosu][ruby-gosu]

### MRuby

Used for its compilability and portability.

**Text-based User Interface (TUI)**

* [Termbox][mruby-termbox]

**Graphical User Interface (GUI)**

* [SDL][mruby-sdl]

### JRuby

Used for compilability, speed, and libraries.  
Ruby FFI based adapters should also work in JRuby.

**Text-based User Interface (TUI)**

* [Lanterna][jruby-lanterna]

**Graphical User Interface (GUI)**

* [AWT][jruby-awt]

## Usage

> **NOTE:** The following is not functional yet. Move along...

```rb
require 'cura'

# Define our window

class MainWindow < Cura::Window
  
  def initialize
    super
    
    @label = Cura::Label.new(
      text: 'Hello, world!',
      bold: true,
      underline: true,
      alignment: { horizontal: :center },
      margin: 10,
      border: { size: 1, color: Cura::Color.red },
      padding: 3
    )
    
    add_child( @label ) # Will mixin any adapter methods for Label
  end
  
end

# Define our application and add our window

class Application < Cura::Application
  
  def initialize
    super
    
    @window = MainWindow.new
    
    add_window( @window )
    
    @window.show # Note that in TUIs, only one window can be shown at once.
  end
  
end

# Require any adapters

require 'cura-adapter-termbox'
require 'cura-adapter-termbox-ffi'
require 'cura-adapter-curses'
require 'cura-adapter-sdl'
require 'cura-adapter-sdl-ffi'
require 'cura-adapter-opengl'
require 'cura-adapter-opengl-ffi'
require 'cura-adapter-gosu'

# Choose adapter

adapter_names = Cura::Adapter.all.collect(&:name)
adapter = loop do
  puts "Choose one or type 'exit': #{ adapter_names.join(', ') }"
  print '> '
  
  answer = gets.downcase.strip
  
  exit if answer == 'exit'
  retry unless adapter_names.include?( answer.to_sym )
end

# Run application with adapter

Application.run( adapter: adapter )
```

## Copyright

Copyright © 2015 Ryan Scott Lewis <ryan@rynet.us>.

The MIT License (MIT) - See LICENSE for further details.

[ruby-termbox]: https://github.com/RyanScottLewis/ruby-cura-adapter-termbox
[ruby-termbox-ffi]: https://github.com/RyanScottLewis/ruby-cura-adapter-termbox-ffi
[ruby-curses]: https://github.com/RyanScottLewis/ruby-cura-adapter-curses
[ruby-sdl]: https://github.com/RyanScottLewis/ruby-cura-adapter-sdl
[ruby-sdl-ffi]: https://github.com/RyanScottLewis/ruby-cura-adapter-sdl-ffi
[ruby-opengl]: https://github.com/RyanScottLewis/ruby-cura-adapter-opengl
[ruby-opengl-ffi]: https://github.com/RyanScottLewis/ruby-cura-adapter-opengl-ffi
[ruby-gosu]: https://github.com/RyanScottLewis/ruby-cura-adapter-gosu
[mruby-termbox]: https://github.com/RyanScottLewis/mruby-cura-adapter-termbox
[mruby-sdl]: https://github.com/RyanScottLewis/mruby-cura-adapter-sdl
[jruby-lanterna]: https://github.com/RyanScottLewis/jruby-cura-adapter-lanterna
[jruby-awt]: https://github.com/RyanScottLewis/jruby-cura-adapter-awt
