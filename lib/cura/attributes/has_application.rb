module Cura
  module Attributes
    
    # Allows an object to belong to a Cura::Application.
    module HasApplication
      
      # Get the application of this object.
      attr_reader :application
      
      # Set the application of this object.
      def application=(value)
        raise TypeError, 'application must nil or be a Cura::Application' unless value.nil? || value.is_a?(Cura::Application)
        
        @application = value
        
        # TODO: Why is it HasApplication's responsibilty to set teh application of it's *possible* children? 
        children.each { |child| child.application = value if child.respond_to?(:application=) } if respond_to?(:children)
        
        @application
      end
      
    end
    
  end
end
