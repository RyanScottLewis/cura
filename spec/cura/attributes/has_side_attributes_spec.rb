require 'spec_helper'
require 'support/shared_examples_for_attributes'

require 'cura/attributes/has_initialize'
require 'cura/attributes/has_side_attributes'

describe Cura::Attributes::HasSideAttributes do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include( Cura::Attributes::HasInitialize )
    instance_class.include( Cura::Attributes::HasSideAttributes )
    
    instance_class.new
  end
  
  it_should_behave_like 'an object with size accessors', :top, :right, :bottom, :left
  
end
