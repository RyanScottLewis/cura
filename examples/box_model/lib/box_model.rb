require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'box_model/application'

module BoxModel
  
  class << self
    
    def run
      Application.run
    end
    
  end
  
end
