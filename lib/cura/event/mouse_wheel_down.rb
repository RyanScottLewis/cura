if Kernel.respond_to?(:require)
  require "cura/event/mouse"
end

module Cura
  module Event
    
    # Dispatched when a mouse's wheel is scrolled down.
    class MouseWheelDown < Mouse
      
    end
    
  end
end
