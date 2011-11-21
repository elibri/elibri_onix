require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse languages info" do
    product = load_fixture("onix_languages_example.xml")
    assert_equal "polski", product.languages[0].language
    assert_equal "language_of_text", product.languages[0].role_name

    assert_equal "angielski", product.languages[1].language
    assert_equal "language_of_abstracts", product.languages[1].role_name
  end

end
