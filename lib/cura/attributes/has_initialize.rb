module Cura
  module Attributes
    # Stops the initialize super chain.
    # Must be included before any Cura::Attributes modules which define an #initialize method.
    module HasInitialize
      def initialize(*_arguments)
        # Blank on purpose. Carry on, my wayward son.
      end
    end
  end
end
