require 'spec_helper'
require 'cura/attributes/has_initialize'
require 'cura/attributes/has_dimensions'

describe Cura::Attributes::HasDimensions do
  
  before do
    @class = Class.new
    @class.include( Cura::Attributes::HasInitialize )
    @class.include( Cura::Attributes::HasDimensions )
  end
  
  describe '#width' do
    
    before do
      @instance = @class.new
    end
    
    it 'should be initialized with the correct value' do
      expect( @instance.width ).to eq( :auto )
    end
    
  end
  
  describe '#width=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.width = 10
      expect( @instance.width ).to eq( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.width = '10'
      expect( @instance.width ).to eq( 10 )
    end
    
    describe 'when a symbol is passed' do
      
      describe 'and it is valid' do
        
        it 'should set the attribute correctly' do
          @instance.width = :inherit
          expect( @instance.width ).to eq( :inherit )
          
          @instance.width = :auto
          expect( @instance.width ).to eq( :auto )
        end
        
      end
        
      describe 'and it is invalid' do
        
        it 'should raise an ArgumentError' do
          expect { @instance.width = :invalid_symbol }.to raise_error(ArgumentError)
        end
        
      end
      
    end
    
  end
  
  describe '#height' do
    
    before do
      @instance = @class.new
    end
    
    it 'should be initialized with the correct value' do
      expect( @instance.height ).to eq( :auto )
    end
    
  end
  
  describe '#height=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.height = 10
      expect( @instance.height ).to eq( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.height = '10'
      expect( @instance.height ).to eq( 10 )
    end
    
    describe 'when a symbol is passed' do
      
      describe 'and it is valid' do
        
        it 'should set the attribute correctly' do
          @instance.height = :inherit
          expect( @instance.height ).to eq( :inherit )
          
          @instance.height = :auto
          expect( @instance.height ).to eq( :auto )
        end
        
      end
        
      describe 'and it is invalid' do
        
        it 'should raise an ArgumentError' do
          expect { @instance.height = :invalid_symbol }.to raise_error(ArgumentError)
        end
        
      end
      
    end
    
  end
  
end
