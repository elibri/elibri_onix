module Elibri
  module ONIX
    module Release_3_0
      class PublishingDate

        attr_accessor :role, :format, :date, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('PublishingDateRole')&.text
          @format = data.at_css('DateFormat')&.text || data.at_css('Date')['dateformat'] || '00'
          @date = data.at_css('Date')&.text
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
