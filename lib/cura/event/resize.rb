if Kernel.respond_to?(:require)
  require "cura/attributes/has_dimensions"
  require "cura/event/base"
end

module Cura
  module Event
    
    # Dispatched when an object is resized.
    class Resize < Base
      
      include Attributes::HasDimensions
      
    end
    
  end
end
