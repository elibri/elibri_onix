require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_contributors_example.xml")

    assert !product.no_contributor?
    assert !product.unnamed_persons?

    cont1 = product.contributors[0]
    cont2 = product.contributors[1]

    assert_equal "author", cont1.role_name
    assert_equal "Św. Tomasz z Akwinu", cont1.person_name
    assert_equal ["Św. Tomasz z Akwinu"], product.authors
    assert cont1.biographical_note.present?

    assert_equal "translator", cont2.role_name
    assert_equal "prof. ks. Henryk von Hausswolff OP", cont2.person_name
    assert_equal ["prof. ks. Henryk von Hausswolff OP"], product.translators
  
    #<Elibri::ONIX::Release_3_0::Contributor role_name: "author", number: 1, role: "A01", person_name: "Św. Tomasz z Akwinu", from_language: nil, titles_before_names: nil, names_before_key: "Św.", prefix_to_key: nil, key_names: "Tomasz z Akwinu", names_after_key: nil, biographical_note: "Tomasz z Akwinu, Akwinata, łac. Thoma de Aquino (u...", unnamed_persons: nil>,
    # #<Elibri::ONIX::Release_3_0::Contributor role_name: "translator", number: 2, role: "B06", person_name: "prof. ks. Henryk von Hausswolff OP", from_language: "lat", titles_before_names: "prof. ks.", names_before_key: "Henryk", prefix_to_key: "von", key_names: "Hausswolff", names_after_key: "OP", biographical_note: nil, unnamed_persons: nil>]
    #

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
