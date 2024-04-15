require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse information about exclusive distrubution restriction" do
    product = load_fixture("onix_exclusive_distributor_example.xml")
    assert product.sales_restrictions?
    assert_equal "EMP", product.exclusive_distributor_onix_code
  end

end
