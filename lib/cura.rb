module Cura
  class << self
    
    def version
      @version ||= '0.0.1'
    end
    
  end
end

if Kernel.respond_to?(:require)
  require 'cura/adapter'
  require 'cura/application'
  require 'cura/window'
  require 'cura/component/group'
  require 'cura/component/pack'
  require 'cura/component/label'
  require 'cura/component/button'
  # require 'cura/component/listbox'
  # require 'cura/component/scrollbar'
  require 'cura/component/textbox'
end
