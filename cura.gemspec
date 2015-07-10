require 'pathname'
require_relative 'lib/cura/version.rb'

# cura : management, administration, care, concern, charge
Gem::Specification.new do |s|

  # Variables
  s.author  = 'Ryan Scott Lewis'
  s.email   = 'ryan@rynet.us'
  s.summary = 'A library written in pure Ruby for building user interfaces.'
  s.license = 'MIT'
  s.version = Cura::VERSION

  # Dependencies
  # s.add_development_dependency 'fuubar', '~> 1.2.1'
  # s.add_development_dependency 'guard-rspec', '~> 3.1.0'
  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'fuubar', '~> 2.0.0'
  s.add_development_dependency 'yard', '~> 0.8.7.6'
  # s.add_development_dependency 'rb-fsevent', '~> 0.9.0'
  
  # Pragmatically set variables
  s.homepage      = "http://github.com/RyanScottLewis/#{s.name}"
  s.description   = s.summary
  s.name          = Pathname.new(__FILE__).basename('.gemspec').to_s
  s.require_paths = ['lib']
  s.files         = Dir['{{Rake,Gem}file{.lock,},README*,VERSION,LICENSE,*.gemspec,{lib,bin,spec}/**/*.rb}']
  s.test_files    = Dir['{examples,spec,test}/**/*']

end
