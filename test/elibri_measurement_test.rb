require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_measurement_example.xml")
    
    assert_equal 4, product.measures.size

    assert_equal 195, product.height
    assert_equal 125, product.width
    assert_equal 20, product.thickness
    assert_equal 90, product.weight
  end

end
