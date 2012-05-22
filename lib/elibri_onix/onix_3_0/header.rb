

module Elibri
  module ONIX
    module Release_3_0

      class Header

        attr_accessor :sent_date_time, :sender, :to_xml
        
        ATTRIBUTES = [
          :sent_date_time, :sender
        ]
        
        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @sent_date_time = Date.parse(data.xpath('xmlns:SentDateTime').text)
          @sender = Sender.new(data.at_xpath('xmlns:Sender'))
        end        
        
      end

    end
  end
end
