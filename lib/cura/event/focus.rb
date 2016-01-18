require "cura/event/base" if Kernel.respond_to?(:require)

module Cura
  module Event
    # Dispatched when a component is focused.
    class Focus < Base
    end
  end
end
