require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse related products info" do
    product = load_fixture("onix_related_products_example.xml")
    assert_equal ["c486ef9c55659d3e123b"], product.related_products_record_references
  end

end
