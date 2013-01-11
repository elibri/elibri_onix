#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse formats and technical protection" do

    product = load_fixture("onix_epub_details_example.xml")
    assert_equal ["EPUB", "MOBI"], product.digital_formats
    assert_equal "DRM", product.technical_protection
  end
end
