#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse the info without the propertiary extensions" do
    product = load_fixture("onix_removed_elibri_extensions.xml")
    assert_equal 12.99, product.cover_price
    assert_equal 5, product.vat
    assert_equal "PROMO 20", product.additional_trade_information
    assert_equal "58.11.1", product.pkwiu
  end

end
