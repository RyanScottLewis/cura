require "cura/event/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    # Dispatched when a component is selected.
    class Selected < Base
    end
  end
end
