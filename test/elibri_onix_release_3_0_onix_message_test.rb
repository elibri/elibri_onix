require 'helper'


describe Elibri::ONIX::Release_3_0::ONIXMessage do


  it "should be able to parse all attributes supported in Elibri" do
    xml_string = File.read File.join(File.dirname(__FILE__), "..", "test", "fixtures", "all_possible_tags.xml")
    
    onix = Elibri::ONIX::Release_3_0::ONIXMessage.from_xml(xml_string)
    assert_equal 'Elibri.com.pl', onix.header.sender.sender_name
    assert_equal 'Tomasz Meka', onix.header.sender.contact_name
    assert_equal 'kontakt@elibri.com.pl', onix.header.sender.email_address
    assert_equal Date.new(2011, 10, 5), onix.header.sent_date_time

    assert_equal 1, onix.products.size 

    product = onix.products.first

    assert_equal 'fdb8fa072be774d97a97', product.record_reference
    assert_equal 3, product.notification_type
    assert_equal "Record had many errors", product.deletion_text 

    assert_equal '9788324799992', product.isbn13
    assert_equal '9788324788882', product.ean13

    assert_equal({"Gildia.pl" => "GILD-123", "PWN" => "pl.pwn.ksiegarnia.produkt.id.76734"}, product.proprietary_identifiers)

    assert_equal 0, product.product_composition 
    assert_equal 'BA', product.product_form

    assert_equal 4, product.measures.size 

    assert_equal 195, product.height 
    assert_equal 'mm', product.height_unit 

    assert_equal 125, product.width
    assert_equal 'mm', product.width_unit 

    assert_equal 20, product.thickness
    assert_equal 'mm', product.thickness_unit 
    
    assert_equal 90.5, product.weight
    assert_equal 'gr', product.weight_unit 

    assert_equal 1, product.collections.size
    assert_equal 'dupa', product.collections.first 

    assert_equal 'Original title', product.original_title
    assert_equal 'Trade title', product.trade_title
    assert_equal 'Collection title (Vol. 1). Title. Subtitle (part 5)', product.full_title

  end


end
