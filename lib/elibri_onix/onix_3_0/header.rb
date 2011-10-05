

module Elibri
  module ONIX
    module Release_3_0

      class Header
        include ROXML

        xml_name 'Header'
        xml_accessor :sent_date_time, :as => Date, :from => 'SentDateTime'

        xml_accessor :sender, :as => Sender
      end

    end
  end
end
