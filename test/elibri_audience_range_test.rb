require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse audience attributes supported in Elibri" do
    product = load_fixture("onix_audience_range_example.xml")

    assert_equal 7, product.reading_age_from
    assert_equal 10, product.reading_age_to

    
  end

end
