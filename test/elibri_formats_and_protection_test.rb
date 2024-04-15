#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse formats and technical protection" do

    product = load_fixture("onix_epub_details_example.xml")
    assert_equal ["EPUB", "MOBI"], product.digital_formats
    assert_equal "watermark", product.technical_protection
    assert_equal "02", product.technical_protection_onix_code
  end
end
