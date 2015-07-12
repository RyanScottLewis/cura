if Kernel.respond_to?(:require)
  require "cura/event/mouse"
end

module Cura
  module Event
    
    # Dispatched when a mouse's button state changes from up to down.
    class MouseUp < Mouse
      
    end
    
  end
end
