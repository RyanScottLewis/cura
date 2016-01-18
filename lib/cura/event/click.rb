require "cura/event/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    # Dispatched when a component is clicked.
    class Click < Base
    end
  end
end
