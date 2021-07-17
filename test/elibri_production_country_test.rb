require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse production country and cn info" do
    product = load_fixture("onix_cn_production_country_example.xml")

    assert_equal "4901", product.cn_code
    assert_equal "DE", product.country_of_manufacture
  end

end
