module TodoList

  class ListItem < Sequel::Model
    many_to_one :list
  end
  
end
