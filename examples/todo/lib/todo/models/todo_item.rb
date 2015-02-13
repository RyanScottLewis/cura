module Todo
  module Models
    
    class TodoItem
      
      class << self
        
        def all
          @all ||= []
        end
        
        def new(*args)
          instance = super
          
          all << instance
          
          instance
        end
        
      end
      
      include Cura::Attributes::HasAttributes
      
      attr_reader :value
      
      def value=(value)
        @value = value
      end
      
    end
    
  end
end
