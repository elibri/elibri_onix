


module Elibri
  module ONIX
    module Release_3_0

      class PublishingDate

        #from ONIX documentation:
        #A repeatable group of data elements which together specify a date associated with the publishing of the product.
        #Optional, but a date of publication must be specified either or in <MarketPublishingDetail> (P.25).
        #Other dates related to the publishing of a product can be sent in further repeats.

        include HashId

        ATTRIBUTES = [
          :role, :format, :date, :parsed
        ]

        RELATIONS = []

        attr_accessor :role, :format, :date, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('PublishingDateRole').try(:text)
          @format = data.at_css('DateFormat').try(:text) || data.at_css('Date')['dateformat'] || '00'
          @date = data.at_css('Date').try(:text)
        end

        def parsed
          case @format
            when '00' then [date[0...4].to_i, date[4...6].to_i, date[6...8].to_i]
            when '01' then [date[0...4].to_i, date[4...6].to_i]
            when '05' then [date[0...4].to_i]
          end
        end

      end

    end
  end
end
