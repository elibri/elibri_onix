#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse contributors info" do
    product = load_fixture("onix_contributors_example.xml")

    assert !product.no_contributor?
    assert !product.unnamed_persons?

    cont1 = product.contributors[0]
    cont2 = product.contributors[1]

    assert_equal "contributorid:255", cont1.id_before_type_cast
    assert_equal 255, cont1.eid
    assert_equal 255, cont1.id
    assert_equal "20111104T0905", cont1.datestamp_before_type_cast
    assert_equal Date.new(2011, 11, 04).to_time + 9.hours + 5.minutes, cont1.datestamp

    assert_equal "author", cont1.role_name
    assert_equal "Św. Tomasz z Akwinu", cont1.person_name
    assert_equal ["Św. Tomasz z Akwinu"], product.authors
    assert cont1.biographical_note.present?

    assert_equal "translator", cont2.role_name
    assert_equal "prof. ks. Henryk von Hausswolff OP", cont2.person_name
    assert_equal ["prof. ks. Henryk von Hausswolff OP"], product.translators
  
    product = load_fixture("onix_no_contributors_example.xml")
    assert product.no_contributor?
    assert !product.unnamed_persons?
    assert_equal [], product.authors


    product = load_fixture("onix_collective_work_example.xml")
    assert !product.no_contributor?
    assert product.unnamed_persons?
    assert_equal ["praca zbiorowa"], product.authors


  end

end
