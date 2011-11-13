require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse measurement attributes supported in Elibri" do
    product = load_fixture("onix_series_memberships_example.xml")
    assert_equal ["Lektury szkolne", "Dla Bystrzaków"], product.series_names

    assert_equal "Lektury szkolne", product.series[0].title
    assert_equal "2", product.series[0].part_number

    assert_equal "Dla Bystrzaków", product.series[1].title
    assert_equal "1", product.series[1].part_number
  end

end
