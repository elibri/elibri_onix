# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{elibri_onix}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcin Urbanski"]
  s.date = %q{2011-10-09}
  s.description = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}
  s.email = %q{marcin@urbanski.vdl.pl}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "elibri_onix.gemspec",
    "lib/elibri_onix.rb",
    "lib/elibri_onix/onix_3_0/audience_range.rb",
    "lib/elibri_onix/onix_3_0/collection.rb",
    "lib/elibri_onix/onix_3_0/contributor.rb",
    "lib/elibri_onix/onix_3_0/extent.rb",
    "lib/elibri_onix/onix_3_0/header.rb",
    "lib/elibri_onix/onix_3_0/imprint.rb",
    "lib/elibri_onix/onix_3_0/language.rb",
    "lib/elibri_onix/onix_3_0/measure.rb",
    "lib/elibri_onix/onix_3_0/onix_message.rb",
    "lib/elibri_onix/onix_3_0/price.rb",
    "lib/elibri_onix/onix_3_0/product.rb",
    "lib/elibri_onix/onix_3_0/product_identifier.rb",
    "lib/elibri_onix/onix_3_0/publisher.rb",
    "lib/elibri_onix/onix_3_0/publishing_date.rb",
    "lib/elibri_onix/onix_3_0/related_product.rb",
    "lib/elibri_onix/onix_3_0/sales_restriction.rb",
    "lib/elibri_onix/onix_3_0/sender.rb",
    "lib/elibri_onix/onix_3_0/stock_quantity_coded.rb",
    "lib/elibri_onix/onix_3_0/subject.rb",
    "lib/elibri_onix/onix_3_0/supplier.rb",
    "lib/elibri_onix/onix_3_0/supplier_identifier.rb",
    "lib/elibri_onix/onix_3_0/supply_detail.rb",
    "lib/elibri_onix/onix_3_0/supporting_resource.rb",
    "lib/elibri_onix/onix_3_0/text_content.rb",
    "lib/elibri_onix/onix_3_0/title_detail.rb",
    "lib/elibri_onix/onix_3_0/title_element.rb",
    "lib/elibri_onix/releases.rb",
    "lib/elibri_onix/version.rb",
    "test/elibri_onix_release_3_0_onix_message_test.rb",
    "test/elibri_onix_test.rb",
    "test/fixtures/all_possible_tags.xml",
    "test/fixtures/old_dialect.xml",
    "test/helper.rb"
  ]
  s.homepage = %q{http://github.com/elibri/elibri_onix}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{EDItEUR ONIX format subset implementation used in Elibri publication system}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roxml>, ["= 3.1.6"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<roxml>, ["= 3.1.6"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 3.1.0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<roxml>, ["= 3.1.6"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 3.1.0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

