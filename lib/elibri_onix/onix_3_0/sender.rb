
module Elibri
  module ONIX
    module Release_3_0

      class Sender
#        include ROXML
#        include Inspector

#        xml_name 'Sender'

#        xml_accessor :sender_name, :from => 'SenderName'
#        xml_accessor :contact_name, :from => 'ContactName'
#        xml_accessor :email_address, :from => 'EmailAddress'
        
        attr_accessor :sender_name, :contact_name, :email_address
        
        ATTRIBUTES = [
          :sender_name, :contact_name, :email_address
        ]
        
        RELATIONS = []
        
        def initialize(data)
          @sender_name = data.at_xpath('//xmlns:SenderName').text
          @contact_name = data.at_xpath('//xmlns:ContactName').text
          @email_address = data.at_xpath('//xmlns:EmailAddress').text
        end
        
      end

    end
  end
end
