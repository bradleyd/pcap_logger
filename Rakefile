#!/usr/bin/env rake

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'rake/testtask'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

desc "Open an irb session preloaded with this library"
task :console do
    sh "irb -Ilib -r pcap_logger"
end


Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end
