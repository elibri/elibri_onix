module Elibri
  module ONIX
    module Release_3_0
      class Publisher
        include Inspector

        #role występuje w tej chwili tylko 01 - główny wydawca

        attr_accessor :role, :name, :eid, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('PublishingRole')&.text
          @name = data.at_css('PublisherName')&.text
          if data.at_css('PublisherIdentifier')
            @eid = data.at_css('PublisherIdentifier').at_css('IDValue')&.text&.to_i
          end
        end

        def inspect_include_fields
          [:eid, :name]
        end
      end
    end
  end
end
