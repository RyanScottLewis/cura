require 'pathname'

LOG_PATH = Pathname.new(__FILE__).join( '..', '..', '..', 'debug.log' )
LOG_PATH.truncate(0) if LOG_PATH.exist?

require 'logger'
LOGGER = Logger.new(LOG_PATH)

require 'cura'

module HelloWorld
  
  # class Application < Cura::Application
  #
  #   on_event(:key_down) do |event|
  #     if event.control? && event.name == :C # CTRL+C
  #       stop
  #     else
  #       @output.text += event.inspect + "\n"
  #     end
  #   end
  #
  #   def initialize(attributes={})
  #     super
  #
  #     window = Cura::Window.new
  #     add_window(window)
  #
  #     pack = Cura::Component::Pack.new( width: window.width, height: window.height, fill: true )
  #     window.add_child(pack)
  #
  #     @output = Cura::Component::Label.new
  #     pack.add_child(@output)
  #   end
  #
  # end
  
  class Application < Cura::Application

    on_event(:key_down) do |event|
      stop if event.control? && event.name == :C # CTRL+C
    end

    attr_accessor :timer_start
    attr_reader :input_result_label
    attr_reader :form_first_name_textbox
    attr_reader :form_last_name_textbox
    attr_reader :form_age_textbox
    attr_reader :form_zip_textbox
    attr_reader :form_submit_button
    attr_reader :people_listbox

    def initialize(attributes={})
      super

      window = Cura::Window.new
      add_window(window)
      window.on_event(:key_down) do |event|
        self.focused_index += 1 if event.control? && event.name == :F
        self.focused_index -= 1 if event.control? && event.name == :B
      end

      pack = Cura::Component::Pack.new( width: window.width, height: window.height, fill: true )
      window.add_child(pack)

      label_header = Cura::Component::Label.new( text: 'Cura', bold: true, underline: true, alignment: { horizontal: :center }, margins: { top: 1 } )
      pack.add_child(label_header)

      label_help = Cura::Component::Label.new( text: 'Press CTRL-C to exit', alignment: { horizontal: :center }, margins: { bottom: 1 } )
      pack.add_child(label_help)

      label_hello = Cura::Component::Label.new( text: 'Hello, world!', alignment: { horizontal: :center } )
      pack.add_child(label_hello)

      label_hello_kanji = Cura::Component::Label.new( text: '今日は', alignment: { horizontal: :center }, margins: { bottom: 1 } )
      pack.add_child(label_hello_kanji)


      input_pack = Cura::Component::Pack.new( fill: true )
      input_header_label = Cura::Component::Label.new( text: 'Type and press Enter to echo for 5 seconds:' )
      input_pack.add_child(input_header_label)

      input_textbox = Cura::Component::Textbox.new
      input_pack.add_child(input_textbox)

      #-----

      @timer_start = nil
      @input_result_label = Cura::Component::Label.new
      input_pack.add_child(@input_result_label)

      input_textbox.on_event(:key_down) do |event|
        if event.name == :enter
          application.timer_start = Time.now
          application.input_result_label.text = input_textbox.text
          clear
        end
      end

      #-----

      pack.add_child(input_pack)



      form_pack = Cura::Component::Pack.new( orientation: :horizontal )

      form_first_name_label = Cura::Component::Label.new( text: 'First Name:', margins: { right: 1 } )
      form_pack.add_child(form_first_name_label)

      @form_first_name_textbox = Cura::Component::Textbox.new( width: 20, margins: { right: 1 } )
      form_pack.add_child(@form_first_name_textbox)
      @form_first_name_textbox.on_event(:key_down) { |event| application.form_submit_button.click if event.name == :enter }

      form_last_name_label = Cura::Component::Label.new( text: 'Last Name:', margins: { right: 1 } )
      form_pack.add_child(form_last_name_label)

      @form_last_name_textbox = Cura::Component::Textbox.new( width: 20, margins: { right: 1 } )
      form_pack.add_child(@form_last_name_textbox)
      @form_last_name_textbox.on_event(:key_down) { |event| application.form_submit_button.click if event.name == :enter }

      form_age_label = Cura::Component::Label.new( text: 'Age:', margins: { right: 1 } )
      form_pack.add_child(form_age_label)

      @form_age_textbox = Cura::Component::Textbox.new( width: 20, margins: { right: 1 } )
      form_pack.add_child(@form_age_textbox)
      @form_age_textbox.on_event(:key_down) { |event| application.form_submit_button.click if event.name == :enter }

      form_zip_label = Cura::Component::Label.new( text: 'ZIP:', margins: { right: 1 } )
      form_pack.add_child(form_zip_label)

      @form_zip_textbox = Cura::Component::Textbox.new( width: 20 )
      form_pack.add_child(@form_zip_textbox)
      @form_zip_textbox.on_event(:key_down) { |event| application.form_submit_button.click if event.name == :enter }

      form_clear_button = Cura::Component::Button.new( text: 'Clear', padding: { left: 1, right: 1 }, margins: { left: 1 } )
      form_pack.add_child(form_clear_button)

      form_clear_button.on_event(:click) { application.clear_form }

      @form_submit_button = Cura::Component::Button.new( text: 'Submit', padding: { left: 1, right: 1 }, margins: { left: 1 } )
      form_pack.add_child(@form_submit_button)

      @form_submit_button.on_event(:click) do |event|
        first = application.form_first_name_textbox.text
        last  = application.form_last_name_textbox.text
        age   = application.form_age_textbox.text
        zip   = application.form_zip_textbox.text

        application.clear_form
        
        label_text_segments = []
        label_text_segments << "First: #{first}" unless first.empty?
        label_text_segments << "Last: #{last}" unless last.empty?
        label_text_segments << "Age: #{age}" unless age.empty?
        label_text_segments << "ZIP: #{zip}" unless zip.empty?
        
        label = Cura::Component::Label.new( text: label_text_segments.join(' - ') )
        application.people_listbox.add_child(label)
      end
      pack.add_child(form_pack)

      people_label = Cura::Component::Label.new( text: 'People:' )
      pack.add_child(people_label)
      
      @people_listbox = Cura::Component::Listbox.new
      @people_listbox.on_event(:key_down) { |event| delete_child(selected_child) if event.control? && event.name == :D }

      pack.add_child(@people_listbox)
      
      

      input_textbox.focus
    end

    def update
      super

      if !@timer_start.nil? && Time.now - @timer_start > 5
        @timer_start = nil
        @input_result_label.text = nil
      end
    end

    def clear_form
      @form_first_name_textbox.clear
      @form_last_name_textbox.clear
      @form_age_textbox.clear
      @form_zip_textbox.clear

      @form_first_name_textbox.focus
    end

  end
 
end
