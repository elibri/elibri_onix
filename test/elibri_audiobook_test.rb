#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse audiobook info" do
    product = load_fixture("onix_audiobook_example.xml")

    assert_equal 1, product.excerpt_infos.size
    e = product.excerpt_infos[0]

    assert_equal 2589928, e.file_size
    assert_equal "0bf20c528f323dd2a6d91627ccddf52e", e.md5
    assert_equal "mp3_excerpt", e.file_type
    assert_equal Time.new(2019, 7, 12, 21, 58), e.updated_at
    assert_equal "https://www.elibri.com.pl/excerpt/109048/0bf20c528f323dd2a6d91627ccddf52e/kwiaty-dla-algernona-fragment.mp3", e.link
    assert_equal 109048, e.eid

    assert_equal 524, product.duration
    assert_equal "audio recording file", product.product_form_name

    assert_equal 23, product.vat
    assert_equal 34.90, product.cover_price

    assert_equal '9788380625952', product.isbn13
    assert_equal '9788380625952', product.hyphenated_isbn

    assert_equal "20250307", product.licence_limited_to_before_type_cast
    assert_equal Date.new(2025, 3, 7), product.licence_limited_to
    refute product.unlimited_licence
  end

end
