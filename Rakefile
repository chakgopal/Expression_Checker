# frozen_string_literal: true

require 'rake/testtask'
require 'rspec/core/rake_task'
require_relative 'src/main.rb'

task :default do |_t, _args|
  desc 'main program'
  main
end

RSpec::Core::RakeTask.new(:spec)