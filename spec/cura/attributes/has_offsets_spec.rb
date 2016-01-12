require "spec_helper"

require "cura/attributes/has_initialize"
require "cura/attributes/has_offsets"

describe Cura::Attributes::HasOffsets do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include(Cura::Attributes::HasInitialize)
    instance_class.include(Cura::Attributes::HasOffsets)
    
    instance_class.new
  end
  
  pending
  
end
