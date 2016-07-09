require "cura/attributes/has_attributes" if Kernel.respond_to?(:require)

module Cura
  module Attributes
    # Adds the `#visible?`, `visible=` methods.
    module HasVisibility
      include HasAttributes

      def initialize(attributes={})
        @visible = true

        super
      end

      # Get the visibility.
      #
      # @return [Boolean]
      def visible?
        @visible
      end

      # Set the visibility.
      #
      # @return [Boolean]
      def visible=(value)
        @visible = !!value
      end
    end
  end
end
