require 'spec_helper'

require 'cura/attributes/has_initialize'
require 'cura/attributes/has_ancestry'

describe Cura::Attributes::HasAncestry do
  
  before do
    @class = Class.new
    @class.include( Cura::Attributes::HasInitialize )
    @class.include( Cura::Attributes::HasAncestry )
  end
  
  describe '#parent' do
    
    let(:instance) { @class.new }
    
    it 'should be initialized with the correct value' do
      expect( instance.parent ).to eq( nil )
    end
    
  end
  
  describe '#parent=' do
    
    let(:parent) { Object.new }
    let(:instance) { @class.new }
    
    before { instance.parent = parent }
    
    it 'should set the attribute correctly' do
      expect( instance.parent ).to eq( parent )
    end
    
  end
  
  describe '#parent?' do
    
    context 'when the parent is unset' do
      
      let(:instance) { @class.new }
      
      it 'should return the correct value' do
        expect( instance.parent? ).to eq( false )
      end
      
    end
    
    context 'when the parent is set' do
      
      let(:instance) { @class.new }
      
      before { instance.parent = Object.new }
      
      it 'should return the correct value' do
        expect( instance.parent? ).to eq( true )
      end
      
    end
    
  end
  
  describe '#ancestors' do
    
    let(:instance) { @class.new }
    
    it 'should be initialized with the correct value' do
      expect( instance.ancestors ).to eq( [] )
    end
    
    context 'when the parent is unset' do
      
      let(:parent) { Object.new }
      
      before { instance.parent = nil }
      
      it 'should return the correct value' do
        expect( instance.ancestors ).to eq( [] )
      end
      
    end
    
    context 'when the parent is set' do
      
      let(:parent) { Object.new }
      
      before { instance.parent = parent }
      
      it 'should return the correct value' do
        expect( instance.ancestors ).to eq( [ parent ] )
      end
      
      context 'and the parent has a parent' do
        
        let(:parent) { @class.new }
        let(:grandparent) { Object.new }
        
        before do
          parent.parent = grandparent
          instance.parent = parent
        end
        
        it 'should return the correct value' do
          expect( instance.ancestors ).to eq( [ parent, grandparent ] )
        end
        
      end
      
    end
    
  end
  
end
