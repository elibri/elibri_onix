require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse publisher name" do
    product = load_fixture("onix_publisher_info_example.xml")
    assert_equal "G+J Gruner+Jahr Polska", product.publisher_name
    assert_equal "National Geographic", product.imprint_name
    
  end

end
