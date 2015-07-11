require 'spec_helper'

require 'cura/attributes/has_initialize'
require 'cura/attributes/has_focusability'

describe Cura::Attributes::HasFocusability do
  
  before do
    @class = Class.new
    @class.include( Cura::Attributes::HasInitialize )
    @class.include( Cura::Attributes::HasFocusability )
  end
  
  describe '#focusable?' do
    
    let(:instance) { @class.new }
    
    it 'should be initialized with the correct value' do
      expect( instance.focusable? ).to eq( false )
    end
    
  end
  
  describe '#focusable=' do
    
    let(:instance) { @class.new }
    
    context 'when a boolean is passed' do
      
      it 'should set the attribute correctly' do
        instance.focusable = true
        expect( instance.focusable? ).to eq( true )
        
        instance.focusable = false
        expect( instance.focusable? ).to eq( false )
      end
      
    end
    
    context 'when a truthy object is passed' do
      
      it 'should set the attribute correctly' do
        instance.focusable = 'truthy object'
        expect( instance.focusable? ).to eq( true )
      end
      
    end
    
    context 'when a falsey object is passed' do
      
      it 'should set the attribute correctly' do
        instance.focusable = nil
        expect( instance.focusable? ).to eq( false )
      end
      
    end
    
  end
  
end
