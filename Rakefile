#!/usr/bin/env rake
require "bundler/gem_tasks"


require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = Elibri::ONIX::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "elibri_onix #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('FIELDS*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
