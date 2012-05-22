require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse attachment informations" do
    product = load_fixture("onix_supporting_resources_example.xml")
    
    assert_equal 2, product.supporting_resources.size

    assert_equal product.supporting_resources.first, product.front_cover

    assert_equal "front_cover", product.supporting_resources.first.content_type_name
    assert_equal "image", product.supporting_resources.first.mode_name
    assert_equal "downloadable_file", product.supporting_resources.first.form_name

    assert_equal "http://elibri.com.pl/sciezka/do/pliku.png", product.front_cover.link
    assert_equal Date.new(2011, 12, 1) + 18.hours + 5.minutes, product.front_cover.datestamp
    assert_equal 667, product.front_cover.eid

    assert_equal "sample_content", product.supporting_resources[1].content_type_name
    assert_equal "text", product.supporting_resources[1].mode_name
    assert_equal "downloadable_file", product.supporting_resources[1].form_name
  end

end
