require 'spec_helper'
require 'cura/attributes/has_initialize'
require 'cura/attributes/has_coordinates'

describe Cura::Attributes::HasCoordinates do
  
  before do
    @class = Class.new
    @class.include( Cura::Attributes::HasInitialize )
    @class.include( Cura::Attributes::HasCoordinates )
  end
  
  describe '#x' do
    
    before do
      @instance = @class.new
    end
    
    it 'should be initialized with the correct value' do
      expect( @instance.x ).to eq( 0 )
    end
    
  end
  
  describe '#x=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.x = 10
      expect( @instance.x ).to eq( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.x = '10'
      expect( @instance.x ).to eq( 10 )
    end
    
  end
  
  describe '#y' do
    
    before do
      @instance = @class.new
    end
    
    it 'should be initialized with the correct value' do
      expect( @instance.y ).to eq( 0 )
    end
    
  end
  
  describe '#y=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.y = 10
      expect( @instance.y ).to eq( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.y = '10'
      expect( @instance.y ).to eq( 10 )
    end
    
  end
  
end
