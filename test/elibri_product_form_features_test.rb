require 'helper'

describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse number of pieces info" do
    product = load_fixture("onix_puzzle_example.xml")

    assert_equal 25, product.number_of_pieces
  end

  it "should be able to parse playing time and number of players" do
    product = load_fixture("onix_board_game_example.xml")

    assert_equal 2, product.players_number_from
    assert_equal 5, product.players_number_to
    assert_equal 20, product.playing_time_from
    assert_nil product.playing_time_to
  end

end
