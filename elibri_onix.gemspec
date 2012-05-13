# -*- encoding: utf-8 -*-
require File.expand_path('../lib/elibri_onix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcin Urbanski"]
  gem.email         = ["marcin@urbanski.vdl.pl"]
  gem.description   = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}
  gem.summary       = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}
  gem.homepage      = "http://github.com/elibri/elibri_onix"
  
  gem.licenses = ["MIT"]

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "elibri_onix"
  gem.require_paths = ["lib"]
  gem.version       = Elibri::ONIX::VERSION
  
  gem.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "FIELDS.rdoc"
  ]
  
  gem.add_runtime_dependency 'activesupport', '>= 2.3.5'
  gem.add_runtime_dependency 'roxml', '= 3.1.3'
  gem.add_runtime_dependency 'i18n'
  gem.add_runtime_dependency 'elibri_onix_dict', '>= 0.0.5'

  gem.add_development_dependency "pry"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "minitest", ">= 0"
  gem.add_development_dependency "bundler", ">= 1.0.0"
  #gem.add_development_dependency "rcov", ">= 0"
  
end
