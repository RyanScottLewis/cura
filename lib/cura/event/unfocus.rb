if Kernel.respond_to?(:require)
  require "cura/event/base"
end

module Cura
  module Event
    
    # Dispatched when a component is unfocused.
    class Unfocus < Base
      
    end
    
  end
end
