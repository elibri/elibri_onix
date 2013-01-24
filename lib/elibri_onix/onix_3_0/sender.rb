
module Elibri
  module ONIX
    module Release_3_0
 
      #Sender of the message
      class Sender
        include Inspector
       
        #name of company, which sent the message
        attr_accessor :sender_name

        #contact person 
        attr_accessor :contact_name

        #contact email
        attr_accessor :email_address

        #xml representation of sender
        attr_accessor :to_xml
        
        #:nodoc:
        ATTRIBUTES = [
          :sender_name, :contact_name, :email_address
        ]
        
        #:nodoc:
        RELATIONS = []

        #:nodoc:
        def inspect_include_fields
          [:sender_name, :contact_name, :email_address]
        end
        
        def initialize(data)
          @to_xml = data.to_s
          @sender_name = data.at_xpath('xmlns:SenderName').text
          @contact_name = data.at_xpath('xmlns:ContactName').text
          @email_address = data.at_xpath('xmlns:EmailAddress').text
        end
        
      end

    end
  end
end
