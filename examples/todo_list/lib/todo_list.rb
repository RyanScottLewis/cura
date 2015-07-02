require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'todo_list/database'
require 'todo_list/application'

module TodoList
  
  class << self
    
    def root
      @root ||= Pathname.new(__FILE__).join( '..', '..' ).expand_path
    end
    
    def run
      Database.setup
      
      Application.run
    end
    
  end
  
end
