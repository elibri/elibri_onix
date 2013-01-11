require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse edition number" do
    product = load_fixture("onix_edition_example.xml")
    assert_equal "wyd. 3, poprawione", product.edition_statement
    assert_equal "Warszawa", product.city_of_publication
  end

end
