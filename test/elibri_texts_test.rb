require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_texts_example.xml")

    assert_equal 4, product.text_contents.size

    assert_equal "1. Wprowadzenie<br/>2. Rozdział pierwszy<br/>[...]", product.table_of_contents
    assert_equal [["Recenzja książki<br/>[...]", "Jan Kowalski"]], product.reviews
    assert_equal "Opis książki<br/>[...]", product.description
    assert_equal ["Fragment książki<br/>[...]"], product.excerpts
  end

end
