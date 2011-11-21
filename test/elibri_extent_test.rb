require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse extent attributes" do
    product = load_fixture("onix_ebook_extent_example.xml")
    assert_equal 150, product.number_of_pages
    assert_equal 12, product.number_of_illustrations
    assert_equal 1, product.file_size

    product = load_fixture("onix_audiobook_extent_example.xml")
    assert_equal 340, product.duration
  end

end
