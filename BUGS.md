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
