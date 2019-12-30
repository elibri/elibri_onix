#encoding: UTF-8
require 'helper'


describe Elibri::ONIX::Release_3_0::ONIXMessage do

  it "should be able to parse all attributes supported in Elibri" do
    xml_string = File.read File.join(File.dirname(__FILE__), "..", "test", "fixtures", "eisbn-pl-sample.xml")

    onix = Elibri::ONIX::Release_3_0::ONIXMessage.new(xml_string)
    assert_equal '3.0', onix.release
    assert_equal({ 
      'release' => '3.0',
      'eisbn:nextPage' => 'https://e-isbn.pl/IsbnWeb/api.xml?idFrom=1401255&max=1'}, onix.attributes)
  end

end
