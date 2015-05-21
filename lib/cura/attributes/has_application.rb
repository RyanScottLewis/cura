if Kernel.respond_to?(:require)
  require 'cura/application'
end

module Cura
  module Attributes
    
    # Allows an object to belong to a Cura::Application.
    module HasApplication
      
      # Get the application of this object.
      # 
      # @return [Application]
      attr_reader :application
      
      # Set the application of this object.
      # 
      # @param [Application] value
      # @return [Application]
      def application=(value)
        raise TypeError, 'application must nil or be a Cura::Application' unless value.nil? || value.is_a?(Cura::Application)
        
        @application = value
      end
      
    end
    
  end
end
