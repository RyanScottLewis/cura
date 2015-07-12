if Kernel.respond_to?(:require)
  require "cura/window"
end

module Cura
  module Attributes
    
    # Allows an object to have windows.
    # TODO: Lots of code is the same as HasChildren
    module HasWindows
      
      def initialize(*arguments)
        @windows = []
        
        super
      end
      
      # Get the windows of this object.
      attr_reader :windows
      
      # Add a window to this object.
      #
      # @param [Window] window
      # @return [Window]
      def add_window(window)
        raise TypeError, "window must be a Cura::Window" unless window.is_a?(Window)
        
        @windows << window
        
        window
      end
      
      # Remove a window from this object's windows at the given index.
      #
      # @param [#to_i] index
      # @return [Window]
      def delete_window_at(index)
        @windows.delete_at(index.to_i)
      end
      
      # Remove a window from this object's windows.
      #
      # @param [Window] window
      # @return [Window]
      def delete_window(window)
        raise TypeError, "window must be a Cura::Window" unless window.is_a?(Window)
        index = @windows.index(window)
        
        delete_window_at(index)
      end
      
      # Remove all windows.
      def delete_windows
        (0...@windows.count).to_a.each { |index| delete_window_at(index) }
      end
      
      protected # TODO: These should be protected?
      
      def update_windows
        windows.each(&:update)
      end
      
      def draw_windows
        windows.each(&:draw)
      end
      
    end
    
  end
end
