require "spec_helper"

require "cura/attributes/has_initialize"
require "cura/attributes/has_relative_coordinates"

describe Cura::Attributes::HasRelativeCoordinates do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include(Cura::Attributes::HasInitialize)
    instance_class.include(Cura::Attributes::HasRelativeCoordinates)
    
    instance_class.new
  end
  
  pending
  
end
