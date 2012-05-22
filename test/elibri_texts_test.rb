#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse texts" do
    product = load_fixture("onix_texts_example.xml")

    assert_equal 4, product.text_contents.size
    
    assert_equal "1. Wprowadzenie<br />2. Rozdział pierwszy<br />[...]", product.table_of_contents.text
    assert_equal Date.new(2011, 12, 04) + 12.hours + 15.minutes, product.table_of_contents.datestamp
    assert_equal 133, product.table_of_contents.eid
    assert_equal 133, product.table_of_contents.id

    assert_equal 1, product.reviews.size
    review = product.reviews.first
    assert_equal "Recenzja książki<br />[...]", review.text
    assert_equal "Jan Kowalski", review.author
    assert_equal "nakanapie.pl", review.source_title
    assert_equal "http://nakanapie.pl/books/420469/reviews/2892.odnalezc-swa-droge", review.source_url
    assert_equal Date.new(2011, 12, 4) + 12.hours + 18.minutes, review.datestamp
    assert_equal 134, review.eid
    assert_equal 134, review.id

    assert_equal "Opis książki<br />[...]", product.description.text
    assert_equal Date.new(2011, 12, 4) + 12.hours + 25.minutes, product.description.datestamp
    assert_equal 135, product.description.eid

    assert_equal 1, product.excerpts.size
    excerpt = product.excerpts.first
    assert_equal "Fragment książki<br />[...]", excerpt.text
    assert_equal Date.new(2011, 12, 4) + 12.hours + 35.minutes, excerpt.datestamp
    assert_equal 136, excerpt.eid
    assert_equal 136, excerpt.id
  end
end
