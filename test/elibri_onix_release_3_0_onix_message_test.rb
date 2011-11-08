require 'helper'



describe Elibri::ONIX::Release_3_0::ONIXMessage do


  it "should be able to parse all attributes supported in Elibri" do
    xml_string = File.read File.join(File.dirname(__FILE__), "..", "test", "fixtures", "all_possible_tags.xml")
    
    onix = Elibri::ONIX::Release_3_0::ONIXMessage.from_xml(xml_string)
    assert_equal '3.0', onix.release
    assert_equal '3.0.1', onix.elibri_dialect
    assert_equal 'Elibri.com.pl', onix.header.sender.sender_name
    assert_equal 'Tomasz Meka', onix.header.sender.contact_name
    assert_equal 'kontakt@elibri.com.pl', onix.header.sender.email_address
    assert_equal Date.new(2011, 10, 5), onix.header.sent_date_time

    assert_equal 1, onix.products.size 

    product = onix.products.first
    assert_equal '3.0.1', product.elibri_dialect

    assert_equal 'miękka', product.cover_type 
    assert_equal 12.99, product.cover_price
    assert_equal 5, product.vat
    assert_equal '58.11.1', product.pkwiu

    assert_equal 'fdb8fa072be774d97a97', product.record_reference
    assert_equal '03', product.notification_type
    assert_equal "Record had many errors", product.deletion_text 

    assert_equal '9788324799992', product.isbn13
    assert_equal '9788324788882', product.ean

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
    assert_equal "Publisher series title (Vol. 1)", product.collections.first.full_title

    assert_equal 'Original title', product.original_title
    assert_equal 'Trade title', product.trade_title
    assert_equal 'Collection title (Vol. 1). Title. Subtitle (part 5)', product.full_title

    assert_equal 1, product.contributors.size 
    product.contributors.first.tap do |sienkiewicz|
      assert_equal 'B06', sienkiewicz.role 
      assert_equal 'pol', sienkiewicz.from_language 
      assert_equal "prof. Henryk von Sienkiewicz Ibrahim", sienkiewicz.person_name
      assert_equal "prof.", sienkiewicz.titles_before_names
      assert_equal "Henryk", sienkiewicz.names_before_key
      assert_equal "von", sienkiewicz.prefix_to_key
      assert_equal "Sienkiewicz", sienkiewicz.key_names
      assert_equal "Ibrahim", sienkiewicz.names_after_key
      assert_equal "Sienkiewicz's biography", sienkiewicz.biographical_note
    end

    assert_equal 'second edition', product.edition_statement

    assert_equal 1, product.languages.size
    assert_equal 1, product.languages.first.role
    assert_equal 'pol', product.languages.first.code

    assert_equal 250, product.number_of_pages
    assert_equal 32, product.number_of_illustrations

    assert_equal 2, product.subjects.size 
    assert !product.subjects[1].main_subject?

    product.subjects[0].tap do |first_subject|
      assert first_subject.main_subject?
      assert_equal 24, first_subject.scheme_identifier
      assert_equal 'elibri.com.pl', first_subject.scheme_name
      assert_equal '1.0', first_subject.scheme_version
      assert_equal '1110', first_subject.code
      assert_equal 'Beletrystyka / Literatura popularna / Powieść historyczna', first_subject.heading_text
    end

    assert_equal 7, product.reading_age_from 
    assert_equal 25, product.reading_age_to

    assert_equal 1, product.text_contents.size
    product.text_contents.first.tap do |book_review|
      assert_equal 7, book_review.type
      assert_equal 0, book_review.audience
      assert_equal 'Jan Kowalski', book_review.author
      assert_equal 'This book is purely <strong>awesome!</strong>', book_review.text.strip
    end

    assert_equal 1, product.supporting_resources.size
    product.supporting_resources.first.tap do |cover|
      assert_equal 1, cover.content_type
      assert_equal 0, cover.audience
      assert_equal 3, cover.mode
      assert_equal 2, cover.form
      assert_equal 'http://elibri.com.pl/path/to/file.png', cover.link
    end

    assert_equal 'National Geographic', product.imprint_name

    assert_equal 'GREG', product.publisher.name 
    assert_equal 1, product.publisher.role

    assert_equal 4, product.publishing_status

    assert_equal 1, product.publishing_date.role
    assert_equal 5, product.publishing_date.format
    assert_equal '2011', product.publishing_date.date

    assert_equal 1, product.sales_restrictions.size
    gildia_restriction = product.sales_restrictions.first
    assert_equal 4, gildia_restriction.type
    assert_equal 'sklep.gildia.pl', gildia_restriction.outlet_name
    assert_equal Date.new(2012, 7, 22), gildia_restriction.end_date

    assert_equal 2, product.related_products.size

    product.related_products.first.tap do |first_related|
      assert_equal 24, first_related.relation_code 
      assert_equal '9788324705818', first_related.isbn13
      assert_equal({"Gildia.pl" => "Title of facsimile"}, first_related.proprietary_identifiers)
    end

    product.related_products[1].tap do |second_related|
      assert_equal 23, second_related.relation_code 
      assert_equal '9788324799992', second_related.isbn13
      assert_equal({"PWN" => "Title of similar book"}, second_related.proprietary_identifiers)
    end

    assert_equal 2, product.supply_details.size 

    product.supply_details.first.tap do |supply_detail|
      supply_detail.supplier.tap do |supplier|
        assert_equal 3, supplier.role
        assert_equal '5213359408', supplier.nip
        assert_equal 'Gildia.pl', supplier.name 
        assert_equal "22 631 40 83", supplier.telephone_number
        assert_equal "bok@gildia.pl", supplier.email_address
        assert_equal "http://gildia.pl", supplier.website
      end

      assert_equal 21, supply_detail.product_availability
      assert_equal 1000, supply_detail.on_hand
      assert_equal 7, supply_detail.pack_quantity

      supply_detail.price.tap do |price|
        assert_equal 2, price.type
        assert_equal 20, price.minimum_order_quantity
        assert_equal 12.99, price.amount
        assert_equal 7, price.vat 
        assert_equal 'PLN', price.currency_code
        assert_equal 2, price.printed_on_product
        assert price.printed_on_product?
        assert_equal 0, price.position_on_product
      end
    end

    product.supply_details[1].tap do |supply_detail|
      assert_equal 'very few', supply_detail.quantity_code
    end
  end


  it "should consider elibri_dialect attribute and ignore attributes unrecognized in specified dialect" do
    xml_string = File.read File.join(File.dirname(__FILE__), "..", "test", "fixtures", "old_dialect.xml")
    
    onix = Elibri::ONIX::Release_3_0::ONIXMessage.from_xml(xml_string)
    assert_equal '3.0', onix.release
    assert_equal '3.0.0', onix.elibri_dialect

    product = onix.products.first
    assert_equal '3.0.0', product.elibri_dialect
    assert_nil product.cover_type 
    assert_nil product.cover_price
    assert_nil product.vat
    assert_nil product.pkwiu
  end

end
