#!/usr/bin/env ruby

SimpleCov.start do
  coverage_dir "spec/coverage"

  add_group "Components", "lib/cura/component"
  add_group "Attributes", "lib/cura/attributes"
  add_group "Events", "lib/cura/event"
end
