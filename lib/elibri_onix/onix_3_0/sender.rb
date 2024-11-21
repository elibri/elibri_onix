module Elibri
  module ONIX
    module Release_3_0
      class Sender
        include Inspector

        #name of company, which sent the message
        attr_accessor :sender_name

        #xml representation of sender
        attr_accessor :to_xml

        #:nodoc:
        def inspect_include_fields
          [:sender_name]
        end

        def initialize(data)
          @to_xml = data.to_s
          @sender_name = data.at_css('SenderName').text
        end

      end
    end
  end
end
