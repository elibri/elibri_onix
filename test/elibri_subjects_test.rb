#encoding: UTF-8
require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse thema subjects info" do
    product = load_fixture("onix_subjects_example.xml")


    assert_equal 3, product.thema_subjects.count

    s1 = product.thema_subjects[0]

    assert_equal "JWCM", s1.code
    assert_equal "Społeczeństwo i nauki społeczne / Działania wojenne i obronność / Siły zbrojne / Lotnictwo wojskowe i wojna w powietrzu", s1.heading_text

    s2 = product.thema_subjects[1]

    assert_equal "1DTP", s2.code
    assert_equal "Kwalifikatory geograficzne / Europa / Europa Wschodnia / Polska", s2.heading_text

    s3 = product.thema_subjects[2]

    assert_equal "3MPBGH", s3.code
    assert_equal "Kwalifikatory chronologiczne / od ok. 1500 do dzisiaj / XX wiek (ok. 1900–1999) " +
                         "/ 1. poł. XX wieku (ok. 1900–1950) / Dwudziestolecie międzywojenne (ok. 1919–1939) / ok. 1920–1929", s3.heading_text

    assert_equal 1, product.publisher_subjects.count

    p1 = product.publisher_subjects[0]

    assert_equal "191", p1.code
    assert_equal "Beletrystyka: Horror", p1.heading_text
  end

end
