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

      # @method visible?
      # Get the visibility.
      #
      # @return [Boolean]

      # @method visible=
      # Set the visibility.
      #
      # @return [Boolean]

      attribute(:visible, query: true)
    end
  end
end
