require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse the product form" do
    product = load_fixture("onix_product_form_example.xml")
    assert_equal "00", product.product_composition
    assert_equal "BA", product.product_form
    assert_equal "book", product.product_form_name
  end

end
