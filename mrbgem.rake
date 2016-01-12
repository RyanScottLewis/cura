MRuby::Gem::Specification.new('cura') do |spec|
  spec.authors = 'Ryan Scott Lewis <ryanscottlewis@lewis-software.com>'
  spec.summary = 'A component toolkit for creating both graphical and text-based user interfaces.'
  spec.license = 'MIT'
  spec.version = '0.0.1'
  
  spec.rbfiles = []
  spec.rbfiles << "#{dir}/lib/cura.rb"
  spec.rbfiles << "#{dir}/lib/cura/version.rb"
  
  # TODO: Can be shortened to "#{dir}/lib/cura/attributes/*.rb"?
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_ancestry.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_application.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_attributes.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_children.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_colors.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_coordinates.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_dimensions.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_events.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_focusability.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_initialize.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_orientation.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_relative_coordinates.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_root.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_side_attributes.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_windows.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/padding.rb"
  spec.rbfiles << "#{dir}/lib/cura/borders.rb"
  spec.rbfiles << "#{dir}/lib/cura/margins.rb"
  spec.rbfiles << "#{dir}/lib/cura/offsets.rb"
  spec.rbfiles << "#{dir}/lib/cura/attributes/has_offsets.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/event.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/error/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/error/invalid_adapter.rb"
  spec.rbfiles << "#{dir}/lib/cura/error/invalid_application.rb"
  spec.rbfiles << "#{dir}/lib/cura/error/invalid_color.rb"
  spec.rbfiles << "#{dir}/lib/cura/error/invalid_component.rb"
  spec.rbfiles << "#{dir}/lib/cura/error/invalid_middleware.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/event/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/click.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/dispatcher.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/focus.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/handler.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/key_down.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/mouse.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/mouse_button.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/mouse_wheel_down.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/mouse_wheel_up.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/resize.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/selected.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/unfocus.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/dispatch.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/aimer/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/aimer/dispatcher_target.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/aimer/mouse_focus.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/aimer/target_option.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/translator/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/event/middleware/translator/mouse_click.rb"
  
  spec.rbfiles << "#{dir}/lib/cura/component/base.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/group.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/pack.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/label.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/button.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/listbox.rb"
  # spec.rbfiles << "#{dir}/lib/cura/component/scrollbar.rb"
  spec.rbfiles << "#{dir}/lib/cura/component/textbox.rb"
  
  
  spec.rbfiles << "#{dir}/lib/cura/adapter.rb"
  spec.rbfiles << "#{dir}/lib/cura/application.rb"
  spec.rbfiles << "#{dir}/lib/cura/color.rb"
  spec.rbfiles << "#{dir}/lib/cura/cursor.rb"
  spec.rbfiles << "#{dir}/lib/cura/focus_controller.rb"
  spec.rbfiles << "#{dir}/lib/cura/key.rb"
  spec.rbfiles << "#{dir}/lib/cura/pencil.rb"
  spec.rbfiles << "#{dir}/lib/cura/window.rb"
end
