if Kernel.respond_to?(:require)
  require "cura/event/base"
end

module Cura
  module Event
    
    # Dispatched when a component is focused.
    class Focus < Base
      
    end
    
  end
end
