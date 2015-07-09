require 'pathname'
require 'rubygems/package_task'
require 'rake/testtask'
require 'yard'

gemspec = Pathname.glob( Pathname.new(__FILE__).join('..', '*.gemspec') ).first
$spec = Gem::Specification.load( gemspec.to_s )

Gem::PackageTask.new($spec) do |task|
  task.need_zip = false
end

YARD::Rake::YardocTask.new

Rake::TestTask.new do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
  task.verbose = true
end
