module Todo
  class Application < Cura::Application
  
    def initialize
      super
    
      @window = MainWindow.new
      
      add_window( @window )
    
      @window.show
    end
  
  end
end
