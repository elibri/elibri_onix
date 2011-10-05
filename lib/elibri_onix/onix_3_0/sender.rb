
module Elibri
  module ONIX
    module Release_3_0

      class Sender
        include ROXML
        xml_name 'Sender'

        xml_accessor :sender_name, :from => 'SenderName'
        xml_accessor :contact_name, :from => 'ContactName'
        xml_accessor :email_address, :from => 'EmailAddress'
      end

    end
  end
end
