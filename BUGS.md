* Mouse cursor doesn't listen to padding within Textbox
* Mouse scrolling with termbox-ffi sometimes gets converted into text and then KeyDown  events:
  Happened when scrolling up, perhaps solvable with a middleware in the terbox-ffi project?
  
  #<Cura::Event::MouseWheelDown:0x007fad528433c8 @x=116, @y=15>
  #<Cura::Event::MouseWheelDown:0x007fad52b4e630 @x=116, @y=15>
  #<Cura::Event::MouseWheelDown:0x007fad529ee808 @x=116, @y=15>
  #<Cura::Event::MouseWheelDown:0x007fad52937b58 @x=116, @y=15>
  #<Cura::Event::KeyDown:0x007fad5281a3d8 @control=false, @name=:escape>
  #<Cura::Event::KeyDown:0x007fad52b17900 @control=false, @name=:left_bracket>
  #<Cura::Event::KeyDown:0x007fad529becc0 @control=false, @name=:M>
  #<Cura::Event::KeyDown:0x007fad5138f378 @control=false, @name=:a>
* todo_list edit list items no longer works
* Click on the "Application":
  /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/event/middleware/translator/mouse_click.rb:31:in `call': undefined method `contains_coordinates?' for #<TodoList::Application> (NoMethodError)
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/event/dispatcher.rb:114:in `block in dispatch_event'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/event/dispatcher.rb:114:in `each'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/event/dispatcher.rb:114:in `dispatch_event'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/event/dispatcher.rb:85:in `run'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/application.rb:224:in `run_event_loop'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/application.rb:102:in `run'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/lib/cura/application.rb:42:in `run'
  	from /Volumes/Media/Code/Projects/cura/ruby-cura/examples/todo_list/lib/todo_list.rb:23:in `run'
  	from ./examples/todo_list/bin/todo_list:14:in `<main>'
