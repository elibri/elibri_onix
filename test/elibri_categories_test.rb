# coding: utf-8

require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse categories informations stored in Elibri" do
    product = load_fixture("onix_categories_example.xml")
    assert_equal 2, product.subjects.size

    assert_equal "1110", product.subjects[0].code
    assert_equal "Historia / II Wojna Światowa / Ruch oporu", product.subjects[0].heading_text
  end

end
