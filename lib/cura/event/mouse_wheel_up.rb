if Kernel.respond_to?(:require)
  require 'cura/event/mouse'
end

module Cura
  module Event
    
    # Dispatched when a mouse's wheel is scrolled up.
    class MouseWheelUp < Mouse
      
    end
    
  end
end
