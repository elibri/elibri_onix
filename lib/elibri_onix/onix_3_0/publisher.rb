


module Elibri
  module ONIX
    module Release_3_0

      class Publisher
        
        ATTRIBUTES = [
          :role, :name, :eid
        ]
        
        RELATIONS = []

        #role występuje w tej chwili tylko 01 - główny wydawca

        attr_accessor :role, :name, :eid, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_xpath('xmlns:PublishingRole').try(:text)
          @name = data.at_xpath('xmlns:PublisherName').try(:text)
          if data.at_xpath('xmlns:PublisherIdentifier')
            @eid = data.at_xpath('xmlns:PublisherIdentifier').at_xpath('xmlns:IDValue').try(:text).try(:to_i)
          end
        end
        
      end

    end
  end
end
