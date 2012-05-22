
module Elibri
  module ONIX
    module Release_3_0

      class Sender
        
        attr_accessor :sender_name, :contact_name, :email_address, :to_xml
        
        ATTRIBUTES = [
          :sender_name, :contact_name, :email_address
        ]
        
        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @sender_name = data.at_xpath('//xmlns:SenderName').text
          @contact_name = data.at_xpath('//xmlns:ContactName').text
          @email_address = data.at_xpath('//xmlns:EmailAddress').text
        end
        
      end

    end
  end
end
