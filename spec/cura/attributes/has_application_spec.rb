require 'spec_helper'

require 'cura/application'
require 'cura/adapter'

require 'cura/attributes/has_application'

describe Cura::Attributes::HasApplication do
  
  before do
    @class = Class.new
    @class.include( Cura::Attributes::HasApplication )
  end
  
  let(:instance) { @class.new }
  
  describe '#application' do
    
    it 'should be initialized with the correct value' do
      expect( instance.application ).to eq( nil )
    end
    
  end
  
  describe '#application=' do
    
    context 'when a Cura::Application is passed' do
        
      let(:application) { Cura::Application.new( adapter: Cura::Adapter.new ) }
      
      before { instance.application = application }
      
      it 'should set the attribute correctly' do
        expect( instance.application ).to eq( application )
      end
      
    end
    
    context 'when nil is passed' do
      
      before { instance.application = nil }
      
      it 'should set the attribute correctly' do
        expect( instance.application ).to eq( nil )
      end
      
    end
    
    context 'when an invalid object is passed' do
      
      it 'should raise an error' do
        expect { instance.application = 'invalid thing' }.to raise_error( Cura::Error::InvalidApplication )
      end
      
    end
    
  end
  
end
