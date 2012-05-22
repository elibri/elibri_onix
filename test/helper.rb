# coding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'minitest/autorun'
require 'mocha'
require 'pry'
#require 'ruby-debug'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'elibri_onix'

class Test::Unit::TestCase
end

def load_fixture(filename)
  xml_string = File.read File.join(File.dirname(__FILE__), "..", "test", "fixtures", filename)
  onix = Elibri::ONIX::Release_3_0::ONIXMessage.from_xml(xml_string)
  return onix.products.first
end
