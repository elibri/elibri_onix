#encoding: UTF-8
require 'helper'


describe "parsing onix lending infos" do

  it "should be able to parse lending info" do
    product = load_fixture("lending_example.xml")

    assert_equal 5, product.vat
    assert_equal 49.90, product.cover_price

    library_supply = product.supply_details[1]
    assert_equal 2, library_supply.prices.size

    price1 = library_supply.prices[0]
    assert_equal Elibri::ONIX::Dict::Release_3_0::PriceQualifier::LIBRARY_PRICE, price1.price_qualifier
    assert_equal "ElibriLendingID", price1.price_identifier.type_name
    assert_equal "25/2 36m.", price1.price_identifier.value
    assert_equal 34, price1.amount

    assert_equal 4, price1.price_constraint_limits.size

    assert_equal 25, price1.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::TIMES }.value
    assert_equal 2, price1.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::CONCURRENT_USERS }.value
    assert_equal 36, price1.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::MONTHS }.value
    assert_equal Date.new(2025,2, 20), price1.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::VALID_FROM }.value



    price2 = library_supply.prices[1]
    assert_equal Elibri::ONIX::Dict::Release_3_0::PriceQualifier::LIBRARY_PRICE, price2.price_qualifier
    assert_equal "ElibriLendingID", price2.price_identifier.type_name
    assert_equal "10/1 bezterminowo", price2.price_identifier.value
    assert_equal 20, price2.amount

    assert_equal 10, price2.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::TIMES }.value
    assert_equal 1, price2.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::CONCURRENT_USERS }.value
    assert_nil price2.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::MONTHS }
    assert_nil price2.price_constraint_limits.find { |c| c.unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::VALID_FROM }
  end

end
