require "cura/event/mouse" if Kernel.respond_to?(:require)

module Cura
  module Event
    # Dispatched when a mouse's wheel is scrolled down.
    class MouseWheelDown < Mouse
    end
  end
end
