# Package task

require "pathname"
require "rubygems/package_task"

PROJECT_ROOT = Pathname.new(__FILE__).join("..").expand_path

gemspec = Pathname.glob(PROJECT_ROOT.join("*.gemspec")).first
spec = Gem::Specification.load(gemspec.to_s)

Gem::PackageTask.new(spec) do |task|
  task.need_zip = false
end

# RSpec

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

# Mutant

desc "Mutation testing"
task :mutant do
  exec("bundle exec mutant --include lib --require cura --use rspec Cura*")
end

# Reek

require "reek/rake/task"

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

# Rubocop

require "rubocop/rake_task"

RuboCop::RakeTask.new do |task|
  task.patterns = ["lib/**/*.rb"]
  # task.formatters = ["fuubar"]
end

# YARD

require "yard"

YARD::Rake::YardocTask.new

# Yardstick

require "yardstick/rake/measurement"
require "yardstick/rake/verify"

options = YAML.load_file(".yardstick.yml")
Yardstick::Rake::Measurement.new(:yardstick, options) do |measurement|
  measurement.output = PROJECT_ROOT.join("doc", "yard", "coverage.txt")
end

Yardstick::Rake::Verify.new do |verify|
  verify.threshold = 100
end

# Graphs

namespace :graph do
  desc "Generate YARD dot file"
  task :yard do
    path = PROJECT_ROOT.join("doc", "graphs", "yard.dot").relative_path_from(PROJECT_ROOT)

    sh("bundle exec yard graph --full --file #{path}")
  end

  desc "Generate png files from dot files"
  task :png do
    renders_path = PROJECT_ROOT.join("doc", "graphs", "renders")
    renders_path.mkpath

    glob_query = PROJECT_ROOT.join("doc", "graphs", "*.dot")

    Pathname.glob(glob_query).each do |input_path|
      output_filename = "#{input_path.basename(".dot")}.png"
      output_path = renders_path.join(output_filename)

      sh("dot -T png \"#{input_path}\" -o \"#{output_path}\"")
    end
  end
end

desc "Generate all graphs"
task :graph do
  Rake::Task["graph:yard"].execute
  Rake::Task["graph:png"].execute
end
