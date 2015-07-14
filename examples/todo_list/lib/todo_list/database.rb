require "sequel"
require "sqlite3"
require "todo_list"

module TodoList
  module Database
    
    class << self
      
      def path
        @path ||= TodoList.root.join("data.db")
      end
      
      def setup
        db_existed = path.exist?
        @connection = Sequel.sqlite(path.to_s)
        
        create_tables unless db_existed
        
        require "todo_list/model/list"
        require "todo_list/model/list_item"
      end
      
      protected
      
      def create_tables
        create_lists_table
        create_list_items_table
      end
      
      def create_lists_table
        @connection.create_table(:lists) do
          primary_key :id
          String :name
        end unless @connection.table_exists?(:lists)
      end
      
      def create_list_items_table
        @connection.create_table(:list_items) do
          primary_key :id
          String :text
          TrueClass :completed, default: false
          foreign_key :list_id, :lists
        end unless @connection.table_exists?(:list_items)
      end
      
    end
    
  end
end
