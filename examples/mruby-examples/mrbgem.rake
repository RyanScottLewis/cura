MRuby::Gem::Specification.new('cura-examples') do |spec|

  spec.license = 'MIT'
  spec.author  = 'Ryan Scott Lewis'
  spec.summary = ''

  spec.rbfiles = []

  spec.rbfiles << "#{dir}/../hello_world/lib/hello_world.rb"

  spec.bins << "hello_world"

end
