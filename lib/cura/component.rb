module Cura
  # The container module for components.
  module Component
    class << self
      # All {Component::Base} subclasses.
      #
      # @return [<Class>]
      def all
        @all ||= []
      end

      # Find a {Component::Base} subclass by it's type.
      #
      # @param [#to_sym] value
      # @return [nil, Class]
      def find_by_type(value)
        value = value.to_sym

        all.find { |component_class| component_class.type == value }
      end
    end
  end
end
