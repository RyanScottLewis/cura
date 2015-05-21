if Kernel.respond_to?(:require)
  require 'cura/attributes/has_initialize'
  require 'cura/attributes/has_side_attributes'
end

module Cura
  
  class Padding
    
    include Attributes::HasInitialize
    include Attributes::HasSideAttributes
    
  end
  
end
