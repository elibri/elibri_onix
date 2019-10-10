require 'helper'


describe "CoverType" do

  it "should be able to determine the cover type" do
    assert_equal "gąbka",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BF", nil)
    assert_equal "miękka",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BC", nil)
    assert_equal "miękka ze skrzydełkami",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BC", "B504")
    assert_equal "plastikowa",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BB", "B413")
    assert_equal "skórzana",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BG", nil)
    assert_equal "twarda",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BB", nil)
    assert_equal "twarda lakierowana",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BB", "B415")
    assert_equal "twarda z obwolutą",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BB", "B501")
    assert_equal "zintegrowana",  Elibri::ONIX::Release_3_0::Product.determine_cover_type("BC", "B412")
  end

end
