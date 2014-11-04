require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rubocop/rake_task'
require "yard"

# RSpec task
RSpec::Core::RakeTask.new(:spec)
task test: :spec

# Rubocop task
RuboCop::RakeTask.new

# Yard docs task
YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
  # t.options = ['--any', '--extra', '--opts']
  t.stats_options = ['--list-undoc']
end

task default: [:spec, :rubocop]
