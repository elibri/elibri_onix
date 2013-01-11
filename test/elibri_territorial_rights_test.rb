#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse territorial rights info" do

    product1 = load_fixture("onix_territorial_rights_example.xml", 0)
    assert product1.sale_restricted_to_poland

    product2 = load_fixture("onix_territorial_rights_example.xml", 1)
    assert !product2.sale_restricted_to_poland
  end
end
