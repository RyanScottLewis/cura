require "spec_helper"

require "cura/attributes/has_initialize"
require "cura/attributes/has_focusability"

describe Cura::Attributes::HasFocusability do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include(Cura::Attributes::HasInitialize)
    instance_class.include(Cura::Attributes::HasFocusability)
    
    instance_class.new
  end
  
  describe "#focusable?" do
    
    it "should be initialized with the correct value" do
      expect(instance.focusable?).to eq(false)
    end
    
  end
  
  describe "#focusable=" do
    
    context "when a boolean is passed" do
      
      it "should set the attribute correctly" do
        instance.focusable = true
        expect(instance.focusable?).to eq(true)
        
        instance.focusable = false
        expect(instance.focusable?).to eq(false)
      end
      
    end
    
    context "when a truthy object is passed" do
      
      it "should set the attribute correctly" do
        instance.focusable = "truthy object"
        expect(instance.focusable?).to eq(true)
      end
      
    end
    
    context "when a falsey object is passed" do
      
      it "should set the attribute correctly" do
        instance.focusable = nil
        expect(instance.focusable?).to eq(false)
      end
      
    end
    
  end
  
end
