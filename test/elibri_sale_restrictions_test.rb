require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_sale_restrictions_example.xml")
    assert product.sales_restrictions?
    assert_equal [2012, 7, 22], product.parsed_publishing_date #data po wygaśnięciu wyłączności empiku
  end

end
