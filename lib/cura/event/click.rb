if Kernel.respond_to?(:require)
  require "cura/event/base"
end

module Cura
  module Event
    
    # Dispatched when a component is clicked.
    class Click < Base
      
    end
    
  end
end
