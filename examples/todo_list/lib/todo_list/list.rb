module TodoList
  
  class List < Sequel::Model
    one_to_many :list_items
  end
  
end
