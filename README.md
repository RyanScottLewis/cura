# Cura

A component toolkit for creating user interfaces.

Cura can be used to create:

* Command-line interfaces (`CLI`).
* Text-based user interfaces (`TUI`).
* Graphical user interfaces (`GUI`).
* Read-Eval-Print-Loops (`REPL`).
* Extensions or functionality in current applications.

Cura is:

* Portable
* * No dependencies on external libraries or gems, besides adapters.
* * Does not use any IO or system-specific methods.
* * Can be used on any Ruby implementation, including MRuby (embeddable).
* Adaptable
* * Adapters exist for implementation and platform specific windowing, drawing, and terminal printing libraries.
* * Easily create adapters for any external library to implement a custom view tree for any application.

Cura provides:

* <s>Command system</s>
* * <s>Simple routing DSL.</s>
* * <s>Class based commands.</s>
* * <s>Windows and \*NIX style option parsing (optional, for use outside of CLI environments).</s>
* * <s>Usable in CLI, TUI, GUI, REPL, or any environment.</s>
* Component system
* * [View tree][view_tree] hierarchy.
* * Box model layouts.
* * <s>CCML, a XML user interface markup language for defining view trees</s>
* Event system
* * Dispatch event loop.
* * Middleware for modifying or translating events.
* * Defining events on any Ruby object.
* * Propagation using both the capturing and the bubbling models and ability to stop propagation.
* Adapter system

> Note: <s>Strikethrough</s> means not yet implemented (wait for 0.1.0)

## Install

### Bundler: `gem 'cura'`

### RubyGems: `gem install cura`

## Adapters

### Ruby

Used for its libraries.

**Text-based User Interface (TUI)**

* [Termbox][ruby-termbox]
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

[view_tree]: http://www.mit.edu/~6.005/fa14/classes/22-graphical-user-interfaces/
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
