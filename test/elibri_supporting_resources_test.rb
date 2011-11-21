require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse attachment informations" do
    product = load_fixture("onix_supporting_resources_example.xml")
    
    assert_equal 2, product.supporting_resources.size
    assert_equal "http://elibri.com.pl/sciezka/do/pliku.png", product.front_cover
  end

end
