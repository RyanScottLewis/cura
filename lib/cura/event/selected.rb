if Kernel.respond_to?(:require)
  require 'cura/event/base'
end

module Cura
  module Event
    
    # Dispatched when a component is selected.
    class Selected < Base
      
    end
    
  end
end
