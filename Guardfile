require "pathname"

guard :bundler do
  files = ["Gemfile"] + Dir["*.gemspec"]

  files.each { |file| watch(file) }
end

# guard :shell, task: "graph:png" do
#   watch(%r{doc/graphs/.+\.dot})
# end

guard :shell do
  watch(%r{doc/graphs/.+\.dot}) do |match|
    input_path = Pathname.new(match[0])

    renders_path = Pathname.new(__FILE__).join("..", "doc", "graphs", "renders").expand_path

    output_filename = "#{input_path.basename(".dot")}.png"
    output_path = renders_path.join(output_filename)

    command = "dot -T png \"#{input_path}\" -o \"#{output_path}\""

    puts(command)
    system(command)
  end
end
#
# group :development, halt_on_fail: true do
#   guard :rspec, cmd: "bundle exec rspec" do
#     watch(%r{lib/.+\.rb})
#     watch(%r{spec/.+\.rb})
#   end
#
#   guard :yard do
#     watch(%r{lib/.+\.rb})
#   end
#
#   guard :yardstick do
#     watch(%r{lib/.+\.rb})
#     watch(".yardstick.yml")
#   end
#
#   guard :rake, task: "graph:yard" do
#     watch(%r{lib/.+\.rb})
#   end
#
#   guard :rubocop do
#     watch(%r{lib/.+\.rb})
#     watch(".rubocop.yml")
#   end
# end
