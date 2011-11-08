


module Elibri
  module ONIX
    module Release_3_0

      class PublishingDate
        include ROXML
        include Inspector

        xml_name 'PublishingDate'

        xml_accessor :role, :from => 'PublishingDateRole', :as => Fixnum
        xml_accessor :format, :from => 'DateFormat', :as => Fixnum
        xml_accessor :date, :from => 'Date'

      end

    end
  end
end
