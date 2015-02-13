if Kernel.respond_to?(:require)
  require 'cura/attributes/has_side_attributes'
end

module Cura
  
  class Padding
    
    include Attributes::HasSideAttributes
    
  end
  
end
