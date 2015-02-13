if Kernel.respond_to?(:require)
  require 'cura/attributes/has_side_attributes'
end

module Cura
  
  class Margins
    
    include Attributes::HasSideAttributes
    
  end
  
end
