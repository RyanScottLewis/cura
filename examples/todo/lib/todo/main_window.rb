module Todo
  class MainWindow < Cura::Window
  
    def initialize
      super
      
      @views = View::Container.new
      add_child(@views)
      
      @views.add_child( :index, View::Index.new )
      @views.add_child( :create, View::Create.new )
      
      @views.show_child(:index)
    end
    
    attr_reader :views
    
  end
end
