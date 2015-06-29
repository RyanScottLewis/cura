require 'cura'

module TodoList
  
  class Model
    
    include Cura::Attributes::HasInitialize
    include Cura::Attributes::HasAttributes
    
    class << self
      
      def attributes
        @attributes ||= []
      end
      
      def attribute(name, &setter_block)
        attributes << name
        
        attr_reader(name)
        
        define_method("#{name}=") { |value| setter_block ? setter_block.call(value) : value }
      end
      
      def table_name
        to_s.split('::').last
      end
      
      def find(id)
        new( TodoList.data[ table_name ][ @id ] )
      end
      
      def all
        TodoList.data[ table_name ].collect { |attributes| new(attributes) }
      end
      
    end
    
    attribute(:id) { |value| value.to_i }
    
    def to_h
      self.class.attributes.inject( {} ) do |name, memo|
        memo[name] = instance_variable_get( "@#{name}" )
        
        memo
      end
    end
    
    def save
      @id ||= TodoList.data.count
      
      TodoList.data[ self.class.table_name ][ @id ] = to_h
      TodoList.save_data
    end
    
  end
  
end
