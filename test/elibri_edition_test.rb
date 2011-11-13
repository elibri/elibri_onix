require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_edition_example.xml")
    assert_equal "wyd. 3, poprawione", product.edition_statement
  end

end
