require "spec_helper"

require "cura/attributes/has_initialize"
require "cura/attributes/has_attributes"

describe Cura::Attributes::HasAttributes do
  
  let(:instance_class) do
    instance_class = Class.new { attr_accessor :name }
    
    instance_class.include(Cura::Attributes::HasInitialize)
    instance_class.include(Cura::Attributes::HasAttributes)
    
    instance_class
  end
  
  describe ".attribute" do
    # TODO
  end
  
  describe "#initialize" do
    
    context "when no arguments are given" do
      
      let(:instance) { instance_class.new }
      
      it "should do nothing" do
        expect(instance.name).to eq(nil)
      end
      
    end
    
    context "when an argument is given" do
      
      let(:instance) { instance_class.new(name: "test") }
      
      it "should set the attribute" do
        expect(instance.name).to eq("test")
      end
      
    end
    
  end
  
  describe "#update_attributes" do
    
    let(:instance) { instance_class.new }
    
    context "when no arguments are given" do
      
      before do
        instance.update_attributes
      end
      
      it "should do nothing" do
        expect(instance.name).to eq(nil)
      end
      
    end
    
    context "when an argument is given" do
      
      before do
        instance.update_attributes(name: "test")
      end
      
      it "should set the attribute" do
        expect(instance.name).to eq("test")
      end
      
    end
    
  end
  
end
