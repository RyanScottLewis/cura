shared_examples "an object with integer accessors" do |*attributes|
  options = attributes.last.is_a?(Hash) ? attributes.pop : {}
  options = { default: 0 }.merge(options)
  
  attributes.each do |attribute|
    
    describe "##{attribute}" do
      
      it "should be initialized with the correct value" do
        expect(instance.send(attribute)).to eq(options[:default])
      end
      
    end

    describe "##{attribute}=" do
      
      it "should set the attribute correctly" do
        instance.send("#{attribute}=", 10)
        expect(instance.send(attribute)).to eq(10)
      end
      
      it "should convert the value to an integer" do
        instance.send("#{attribute}=", "10")
        expect(instance.send(attribute)).to eq(10)
      end
      
    end
    
  end
end

shared_examples "an object with size accessors" do |*attributes|
  options = attributes.last.is_a?(Hash) ? attributes.pop : {}
  options = { default: 0 }.merge(options)
  
  attributes.each do |attribute|
    
    it_should_behave_like "an object with integer accessors", attribute, options
    
    describe "##{attribute}=" do
      
      context "when a symbol is passed" do
        
        context "and it is valid" do
          
          it "should set the attribute correctly" do
            instance.send("#{attribute}=", :inherit)
            expect(instance.send(attribute)).to eq(:inherit)
            
            instance.send("#{attribute}=", :auto)
            expect(instance.send(attribute)).to eq(:auto)
          end
          
        end
          
        context "and it is invalid" do
          
          it "should raise an ArgumentError" do
            expect { instance.send("#{attribute}=", :invalid_symbol) }.to raise_error(ArgumentError)
          end
          
        end
        
      end
      
    end
    
  end
end

shared_examples "an object with color accessors" do |*attributes|
  attributes.each do |attribute|
    
    describe "##{attribute}" do
      
      it "should be initialized with the correct value" do
        expect(instance.send(attribute)).to eq(:inherit)
      end
      
    end
    
    describe "##{attribute}=" do
      
      context "when a Color is passed" do
        
        before { instance.send("#{attribute}=", Cura::Color.red) }
        
        it "should set the attribute correctly" do
          expect(instance.send(attribute)).to eq(Cura::Color.red)
        end
        
      end
      
      context "when a Symbol-like object is passed" do
        
        context "and it is valid" do
          
          it "should set the attribute correctly" do
            instance.send("#{attribute}=", :inherit)
            expect(instance.send(attribute)).to eq(:inherit)
            
            instance.send("#{attribute}=", "inherit")
            expect(instance.send(attribute)).to eq(:inherit)
          end
          
        end
        
        context "and it is invalid" do
          
          it "should set the attribute correctly" do
            expect { instance.send("#{attribute}=", :invalid_symbol) }.to raise_error(Cura::Error::InvalidColor)
            expect { instance.send("#{attribute}=", "invalid_symbol") }.to raise_error(Cura::Error::InvalidColor)
          end
          
        end
        
      end
      
    end
      
  end
end
