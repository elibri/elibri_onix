#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse elibri extensions" do
    product = load_fixture("onix_elibri_extensions_example.xml")
    
    assert_equal "miękka", product.cover_type
    assert_equal 12.99, product.cover_price
    assert_equal 5, product.vat
    assert_equal "58.11.1", product.pkwiu
    assert product.preview_exists?
  end

end
