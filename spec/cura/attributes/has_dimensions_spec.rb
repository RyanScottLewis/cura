require 'minitest/autorun'
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
      @instance.width.must_equal( :auto )
    end
    
  end
  
  describe '#width=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.width = 10
      @instance.width.must_equal( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.width = '10'
      @instance.width.must_equal( 10 )
    end
    
    describe 'when a symbol is passed' do
      
      describe 'and it is valid' do
        
        it 'should set the attribute correctly' do
          @instance.width = :inherit
          @instance.width.must_equal( :inherit )
          
          @instance.width = :auto
          @instance.width.must_equal( :auto )
        end
        
      end
        
      describe 'and it is invalid' do
        
        it 'should raise an ArgumentError' do
          proc { @instance.width = :invalid_symbol }.must_raise(ArgumentError)
        end
        
      end
      
    end
    
  end
  
  describe '#height' do
    
    before do
      @instance = @class.new
    end
    
    it 'should be initialized with the correct value' do
      @instance.height.must_equal( :auto )
    end
    
  end
  
  describe '#height=' do
    
    before do
      @instance = @class.new
    end
    
    it 'should set the attribute correctly' do
      @instance.height = 10
      @instance.height.must_equal( 10 )
    end
    
    it 'should convert the value to an integer' do
      @instance.height = '10'
      @instance.height.must_equal( 10 )
    end
    
    describe 'when a symbol is passed' do
      
      describe 'and it is valid' do
        
        it 'should set the attribute correctly' do
          @instance.height = :inherit
          @instance.height.must_equal( :inherit )
          
          @instance.height = :auto
          @instance.height.must_equal( :auto )
        end
        
      end
        
      describe 'and it is invalid' do
        
        it 'should raise an ArgumentError' do
          proc { @instance.height = :invalid_symbol }.must_raise(ArgumentError)
        end
        
      end
      
    end
    
  end
  
end
