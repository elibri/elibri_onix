

module Elibri
  module ONIX
    module Release_3_0

      class Header
        
        #from ONIX documentation:
        #A group of data elements which together constitute a message header.
        #Mandatory in any ONIX for Books message, and non-repeating.
        #In ONIX 3.0, a number of redundant elements have been deleted, and the Sender and Addressee structures and
        #the name and format of the <SentDateTime> element have been made consistent with other current ONIX formats.

        attr_accessor :sent_date_time, :sender, :to_xml
        
        ATTRIBUTES = [
          :sent_date_time, :sender
        ]
        
        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @sent_date_time = Date.parse(data.xpath('xmlns:SentDateTime').try(:text)) if data.xpath('xmlns:SentDateTime')
          @sender = Sender.new(data.at_xpath('xmlns:Sender')) if data.at_xpath('xmlns:Sender')
        end        
        
      end

    end
  end
end
