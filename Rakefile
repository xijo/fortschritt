require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :demo do
  require_relative 'lib/fortschritt'
  count = ENV['COUNT'] ? ENV['COUNT'].to_i : 1000
  (1..count).to_a.with_fortschritt.each do |i|
    i.fortschritt
    sleep rand/50
  end
end
