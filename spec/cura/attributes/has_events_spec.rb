require 'spec_helper'

require 'cura/attributes/has_initialize'
require 'cura/attributes/has_events'

describe Cura::Attributes::HasEvents do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include( Cura::Attributes::HasInitialize )
    instance_class.include( Cura::Attributes::HasEvents )
    
    instance_class.new
  end
  
  pending
  
end
