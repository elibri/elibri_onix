#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse texts" do
    product = load_fixture("onix_texts_example.xml")

    assert_equal 4, product.text_contents.size

    assert_equal "<p>1. Wprowadzenie</p> <p>2. Rozdział pierwszy</p> <p>[...]</p>", product.table_of_contents.text
    assert_equal Time.new(2011, 12, 04, 13, 15), product.table_of_contents.datestamp
    assert_equal 133, product.table_of_contents.eid

    assert_equal 1, product.reviews.size
    review = product.reviews.first
    assert_equal "<p>Recenzja książki</p> <p>[...]</p>", review.text
    assert_equal "Jan Kowalski", review.author
    assert_equal "nakanapie.pl", review.source_title
    assert_equal "http://nakanapie.pl/books/420469/reviews/2892.odnalezc-swa-droge", review.source_url
    assert_equal Time.new(2011, 12, 4, 13, 18), review.datestamp
    assert_equal 134, review.eid

    assert_equal "<p>Opis książki</p> <p>[...]</p>", product.description.text
    assert_equal Time.new(2011, 12, 4, 13, 25), product.description.datestamp
    assert_equal 135, product.description.eid

    assert_equal 1, product.excerpts.size
    excerpt = product.excerpts.first
    assert_equal "<p>Fragment książki</p> <p>[...]</p>", excerpt.text
    assert_equal Time.new(2011, 12, 4, 13, 35), excerpt.datestamp
    assert_equal 136, excerpt.eid
  end
end
