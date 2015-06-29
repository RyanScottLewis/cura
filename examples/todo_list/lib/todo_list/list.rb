require 'cura'
require 'todo_list/model'

module TodoList
  
  class List < Model
    
    attribute(:name) { |value| value.to_s }
    
  end
  
end
