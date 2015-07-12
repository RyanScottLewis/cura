require "spec_helper"

require "cura/component/base"

require "cura/attributes/has_children"

describe Cura::Attributes::HasChildren do
  
  let(:instance) do
    instance_class = Class.new
    instance_class.include(Cura::Attributes::HasChildren)
    
    instance_class.new
  end
  
  let(:child_class) do
    instance_class = Class.new(Cura::Component::Base)
    instance_class.include(Cura::Attributes::HasChildren)
    
    instance_class
  end
  
  let(:child_1) { child_class.new }
  let(:child_2) { child_class.new }
  let(:children) { [child_1, child_2] }
  
  describe "#children" do
    
    it "should be initialized with the correct value" do
      expect(instance.children).to eq([])
    end
    
    context "when recursive is unset" do
      
      before do
        instance.add_children(*children)
      end
      
      it "should return it's children" do
        expect(instance.children).to eq(children)
      end
      
    end
    
    context "when recursive is set" do
      
      let(:child) { child_class.new }
      
      before do
        instance.add_child(child)
        child.add_children(*children)
      end
      
      it "should return all of it's children's children as well" do
        expect(instance.children(true)).to eq([child] + children)
      end
      
    end
    
  end
  
  describe "#add_child" do
    
    before do
      instance.add_child(child_1)
      instance.add_child(child_2)
    end
    
    it "should add the children" do
      expect(instance.children).to eq([child_1, child_2])
    end
    
  end
  
  describe "#add_children" do
    
    before do
      instance.add_children(child_1, child_2)
    end
    
    it "should add the children" do
      expect(instance.children).to eq([child_1, child_2])
    end
    
  end
  
  describe "#delete_child_at" do
    
    before do
      instance.add_children(child_1, child_2)
    end
    
    context "when a positive index is given" do
      
      before do
        instance.delete_child_at(1)
      end
      
      it "should delete the child" do
        expect(instance.children).to eq([child_1])
      end
      
    end
    
    context "when a negative index is given" do
      
      before do
        instance.delete_child_at(-1)
      end
      
      it "should delete the child" do
        expect(instance.children).to eq([child_1])
      end
      
    end
    
  end
  
  describe "#delete_child" do
    
    before do
      instance.add_children(child_1, child_2)
      instance.delete_child(child_2)
    end
    
    it "should delete the child" do
      expect(instance.children).to eq([child_1])
    end
    
  end
  
  describe "#delete_children" do
    
    before do
      instance.add_children(child_1, child_2)
      instance.delete_children
    end
    
    it "should delete all children" do
      expect(instance.children).to eq([])
    end
    
  end
  
  describe "#children?" do
      
    context "when there aren't children" do
      
      it "should return false" do
        expect(instance.children?).to eq(false)
      end
      
    end
    
    context "when there are children" do
      
      before do
        instance.add_children(child_1, child_2)
      end
      
      it "should return true" do
        expect(instance.children?).to eq(true)
      end
      
    end
    
  end
  
end
