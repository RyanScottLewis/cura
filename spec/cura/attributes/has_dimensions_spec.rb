require "spec_helper"
require "support/shared_examples_for_attributes"

require "cura/attributes/has_initialize"
require "cura/attributes/has_dimensions"

describe Cura::Attributes::HasDimensions do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include(Cura::Attributes::HasInitialize)
    instance_class.include(Cura::Attributes::HasDimensions)
    
    instance_class.new
  end
  
  it_should_behave_like "an object with size accessors", :width, :height, default: :auto
  
end
