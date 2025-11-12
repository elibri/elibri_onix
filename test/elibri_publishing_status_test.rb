require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to recognize announced state" do
    product = load_fixture("onix_announced_product_example.xml")
    assert_equal "01", product.notification_type
    assert_equal "02", product.publishing_status
    assert_equal :announced, product.current_state
    assert_equal [2011], product.parsed_publishing_date
    assert product.premiere.nil? #nieznana jest dokładna data premiery
    assert !product.sales_restrictions?
  end

  it "should be able to recognize preorder state" do
    product = load_fixture("onix_preorder_product_example.xml")
    assert_equal "02", product.notification_type
    assert_equal "02", product.publishing_status
    assert_equal :preorder, product.current_state
    assert_equal [2011, 2, 10], product.parsed_publishing_date
    assert_equal Date.new(2011, 2, 10), product.premiere
    assert_equal Date.new(2011, 2, 1), product.preorder_embargo_date
    assert !product.sales_restrictions?
  end

  it "should be able to recognize published state" do
    product = load_fixture("onix_published_product_example.xml")
    assert_equal "03", product.notification_type
    assert_equal "04", product.publishing_status
    assert_equal :published, product.current_state
    assert_equal [2011, 2], product.parsed_publishing_date
    assert product.premiere.nil?
    assert !product.sales_restrictions?
  end

  it "should be able to recognize out_of_print state" do
    product = load_fixture("onix_out_of_print_product_example.xml")
    assert_equal "03", product.notification_type
    assert_equal "07", product.publishing_status
    assert_equal :out_of_print, product.current_state
    assert_equal [], product.parsed_publishing_date
    assert product.premiere.nil?
    assert !product.sales_restrictions?
  end

  it "should be able recognize cancelled state" do
    product = load_fixture("onix_cancelled_product_example.xml")
    assert_equal "02", product.notification_type
    assert_equal "01", product.publishing_status
    assert_equal :cancelled, product.current_state
  end

  it "should be able recognize deleted state" do
    product = load_fixture("onix_deleted_product_example.xml")
    assert_equal "05", product.notification_type
    assert_equal "00", product.publishing_status
    assert_equal :deleted, product.current_state
    assert_equal "Błędnie założony rekord", product.deletion_text
  end

  it "should be able recognize indefinitely_postponed state" do
    product = load_fixture("onix_indefinitely_postponed_product_example.xml")
    assert_equal "02", product.notification_type
    assert_equal "03", product.publishing_status
    assert_equal :indefinitely_postponed, product.current_state
  end

end
