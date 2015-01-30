module Cura
  module Event
    
    # Dispatched when an object is resized.
    class Resize < Base
      
      include Attributes::HasDimensions
      
    end
    
  end
end
