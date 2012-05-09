
module Elibri
  module ONIX
    module Release_3_0

      class Sender
        include ROXML
        include Inspector

        xml_name 'Sender'

        xml_accessor :sender_name, :from => 'SenderName'
        xml_accessor :contact_name, :from => 'ContactName'
        xml_accessor :email_address, :from => 'EmailAddress'
        
        ATTRIBUTES = [
          :sender_name, :contact_name, :email_address
        ]
        
        RELATIONS = []
        
      end

    end
  end
end
