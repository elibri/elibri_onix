

module Elibri
  module ONIX
    module Release_3_0

      class Header
#        include ROXML
#        include Inspector

#        xml_name 'Header'
#        xml_accessor :sent_date_time, :as => Date, :from => 'SentDateTime'

#        xml_accessor :sender, :as => Sender

        attr_accessor :sent_date_time, :sender, :to_xml
        
        ATTRIBUTES = [
          :sent_date_time, :sender
        ]
        
        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @sent_date_time = Date.parse(data.xpath('//xmlns:SentDateTime').text)
          @sender = Sender.new(data.at_xpath('//xmlns:Sender'))
        end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end
        
        
      end

    end
  end
end
