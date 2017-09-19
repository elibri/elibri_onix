# -*- encoding: utf-8 -*-
require File.expand_path('../lib/elibri_onix/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marcin Urbanski", "Piotr Szmielew"]
  gem.email         = ["marcin@urbanski.vdl.pl", "p.szmielew@ava.waw.pl"]
  gem.description   = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}
  gem.summary       = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}
  gem.homepage      = "http://github.com/elibri/elibri_onix"

  gem.licenses = ["MIT"]

  gem.files         = Dir["{lib}/**/*"] + %w(Rakefile README.rdoc FIELDS.rdoc LICENSE.txt)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "elibri_onix"
  gem.require_paths = ["lib"]
  gem.version       = Elibri::ONIX::VERSION

  gem.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc",
    "FIELDS.rdoc"
  ]

  gem.add_runtime_dependency 'activesupport', '>= 2.3.5', '<5'
  gem.add_runtime_dependency 'nokogiri', '~>1.4'
  gem.add_runtime_dependency 'i18n'
  gem.add_runtime_dependency 'elibri_onix_dict', '>= 0.0.5'

  gem.add_development_dependency "pry"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "minitest", ">= 0"
  gem.add_development_dependency "bundler", "~> 1.15"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rdoc"
  #gem.add_development_dependency "ruby-debug"
  #gem.add_development_dependency "rcov", ">= 0"

end
