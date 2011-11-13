


module Elibri
  module ONIX
    module Release_3_0

      class PublishingDate
        include ROXML
        include Inspector

        xml_name 'PublishingDate'

        xml_accessor :role, :from => 'PublishingDateRole'
        xml_accessor :format, :from => 'DateFormat'
        xml_accessor :date, :from => 'Date'

        def parsed
          case format
            when '00' then [date[0...4].to_i, date[4...6].to_i, date[6...8].to_i]
            when '01' then [date[0...4].to_i, date[4...6].to_i]
            when '05' then [date[0...4].to_i]
          end
        end

      end

    end
  end
end
