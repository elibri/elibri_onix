#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse licence end info" do

    product = load_fixture("onix_unlimited_book_sample_example.xml") 
    assert product.unlimited_licence

    product = load_fixture("onix_epub_details_example.xml")
    assert !product.unlimited_licence
    assert_equal "20140307", product.licence_limited_to_before_type_cast
    assert_equal Date.new(2014, 3, 7), product.licence_limited_to
  end
end
