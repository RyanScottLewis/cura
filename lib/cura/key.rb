module Cura
  
  module Key
    
    CODES = {
      cancel:        3,
      help:          6,
      backspace:     8,
      tab:           9,
      clear:         12,
      return:        13,
      enter:         14,
      shift:         16,
      control:       17,
      alt:           18,
      pause:         19,
      caps_lock:     20,
      escape:        27,
      # space:         32,
      page_up:       33,
      page_down:     34,
      end:           35,
      home:          36,
      left:          37,
      up:            38,
      right:         39,
      down:          40,
      printscreen:   44,
      insert:        45,
      delete:        46,
      # semicolon:     59,
      # equals:        61,
      context_menu:  93,
      numpad0:       96,
      numpad1:       97,
      numpad2:       98,
      numpad3:       99,
      numpad4:       100,
      numpad5:       101,
      numpad6:       102,
      numpad7:       103,
      numpad8:       104,
      numpad9:       105,
      multiply:      106,
      add:           107,
      separator:     108,
      subtract:      109,
      decimal:       110,
      divide:        111,
      f1:            112,
      f2:            113,
      f3:            114,
      f4:            115,
      f5:            116,
      f6:            117,
      f7:            118,
      f8:            119,
      f9:            120,
      f10:           121,
      f11:           122,
      f12:           123,
      f13:           124,
      f14:           125,
      f15:           126,
      f16:           127,
      f17:           128,
      f18:           129,
      f19:           130,
      f20:           131,
      f21:           132,
      f22:           133,
      f23:           134,
      f24:           135,
      num_lock:      144,
      scroll_lock:   145,
      # comma:         188,
      # dash:          189,
      # period:        190,
      # slash:         191,
      # back_quote:    192,
      # open_bracket:  219,
      # back_slash:    220,
      # close_bracket: 221,
      # quote:         222,
      meta:          224
    }
    
    class << self
      
      # Retrieve the key code from the key name.
      # 
      # @param [#to_s] name
      # @return [Integer]
      def code_from_name(name)
        name = name.to_s.strip.downcase.to_sym
        result = Key::CODES.find { |key, value| key == name }
        
        return nil if result.nil?
        
        result[1]
      end
      # Retrieve the key name from the key code.
      # 
      # @param [#to_i] code
      # @return [Symbol]
      def name_from_code(code)
        code = code.to_i
        result = Key::CODES.find { |key, value| value == code }
        
        return nil if result.nil?
        
        result[0]
      end
      
    end
    
  end
  
end
