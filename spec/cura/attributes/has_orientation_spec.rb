require 'spec_helper'

require 'cura/attributes/has_initialize'
require 'cura/attributes/has_orientation'

describe Cura::Attributes::HasOrientation do
  
  let(:instance_class) do
    instance_class = Class.new
    instance_class.include( Cura::Attributes::HasInitialize )
    instance_class.include( Cura::Attributes::HasOrientation )
    
    instance_class
  end
  
  let(:instance) { instance_class.new }
  
  describe "#orientation" do
    
    it "should be initialized with the correct value" do
      expect( instance.orientation ).to eq( :vertical )
    end
    
  end
  
  describe "#orientation=" do
    
    context "when a symbol is passed" do
      
      context "and it is valid" do
        
        it "should set the attribute correctly" do
          instance.orientation = :horizontal
          expect( instance.orientation ).to eq( :horizontal )
          
          instance.orientation = :vertical
          expect( instance.orientation ).to eq( :vertical )
        end
        
      end
        
      context "and it is invalid" do
        
        it "should raise an ArgumentError" do
          expect { instance.orientation = :invalid_symbol }.to raise_error( ArgumentError )
        end
        
      end
      
    end
    
  end
  
  describe "#horizontal?" do
    
    context "when the orientation is set to :vertical" do
      
      let(:instance) { instance_class.new( orientation: :vertical ) }
      
      it "should return the correct value" do
        expect( instance.horizontal? ).to eq( false )
      end
      
    end
    
    context "when the orientation is set to :horizontal" do
      
      let(:instance) { instance_class.new( orientation: :horizontal ) }
      
      it "should return the correct value" do
        expect( instance.horizontal? ).to eq( true )
      end
      
    end
    
  end
  
  describe "#vertical?" do
    
    context "when the orientation is set to :vertical" do
      
      let(:instance) { instance_class.new( orientation: :vertical ) }
      
      it "should return the correct value" do
        expect( instance.vertical? ).to eq( true )
      end
      
    end
    
    context "when the orientation is set to :horizontal" do
      
      let(:instance) { instance_class.new( orientation: :horizontal ) }
      
      it "should return the correct value" do
        expect( instance.vertical? ).to eq( false )
      end
      
    end
    
  end
  
end
