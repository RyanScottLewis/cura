module Cura
  module Attributes
    # Allows an object to have a `parent` and `ancestors`.
    module HasAncestry
      def initialize(attributes={})
        @ancestors = []

        super
      end

      # Get/set the parent of this object.
      # It's not recommended to set this directly as it may break the ancestory chain.
      #
      # @return [Object]
      attr_accessor :parent

      # Determine if this object has a parent.
      #
      # @return [Boolean]
      def parent?
        !@parent.nil?
      end

      # Get the ancestors of this object.
      #
      # @return [Array<Object>]
      def ancestors
        if @parent.nil?
          []
        else
          @parent.respond_to?(:ancestors) ? [@parent] + @parent.ancestors : [@parent]
        end
      end
    end
  end
end
