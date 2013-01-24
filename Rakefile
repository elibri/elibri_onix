#!/usr/bin/env rake
require "bundler/gem_tasks"


require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

=begin
require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end
=end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = Elibri::ONIX::VERSION
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = 'doc'
  rdoc.title = "elibri_onix #{version}"
  rdoc.options << "--hyperlink-all"
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('FIELDS.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
