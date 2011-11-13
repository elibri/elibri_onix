require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_record_identifiers_example.xml")
    
    assert_equal "fdb8fa072be774d97a97", product.record_reference
    assert_equal '9788324799992', product.isbn13
    assert_equal '9788324788882', product.ean

    assert_equal({"Olesiejuk" => "355006"}, product.proprietary_identifiers)

  end

end
