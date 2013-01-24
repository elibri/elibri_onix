

module Elibri
  module ONIX
    module Release_3_0

      #Class representing ONIX header
      class Header
        
        #date, at which message was sent
        attr_accessor :sent_date_time
   
        #sender of the message - Elibri::ONIX::Release_3_0::Sender
        attr_accessor :sender
 
        #xml representation of message header
        attr_accessor :to_xml
 
        #:nodoc:       
        ATTRIBUTES = [
          :sent_date_time, :sender
        ]
        
        #:nodoc:
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
