#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse titles" do
    product = load_fixture("onix_titles_example.xml")
 
    assert_equal "Nothing to Envy: Ordinary Lives in North Korea", product.original_title
    assert_equal "Światu nie mamy czego zazdrościć. Zwyczajne losy mieszkańców Korei Północnej.", product.full_title
    assert_equal "Światu nie mamy czego zazdrościć.", product.title
    assert_equal "Zwyczajne losy mieszkańców Korei Północnej.", product.subtitle
    assert_equal "ŚWIATU NIE MAMY CZEGO ZAZDROŚCIĆ.", product.trade_title

    product = load_fixture("onix_title_with_collection_example.xml")

    assert_equal "Thorgal (#33). Statek-Miecz", product.full_title
    assert_equal "Statek-Miecz", product.title
    assert_equal "Thorgal", product.collection_title
    assert_equal "33", product.collection_part


  end

end
