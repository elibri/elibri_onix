require 'helper'


describe Elibri::ONIX do

  it "should be able to establish its version" do
    assert_match %r{\d+\.\d+\.\d+}, Elibri::ONIX::VERSION
    assert_match %r{\d+\.\d+\.\d+}, Elibri::ONIX::Version
  end

end
