#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse contributors info" do
    product = load_fixture("onix_published_group_product_example.xml")

    assert !product.no_contributor?
    assert product.unnamed_persons?

    cont1 = product.contributors[0]

#    assert_equal "contributorid:255", cont1.id_before_type_cast
    assert_nil cont1.eid
    assert_nil cont1.datestamp_before_type_cast

    assert_equal "author", cont1.role_name
    assert_nil cont1.person_name
    assert_equal ["praca zbiorowa"], product.authors
    assert !cont1.biographical_note.present?

  end

end
