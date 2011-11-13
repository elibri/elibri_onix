


module Elibri
  module ONIX
    module Release_3_0

      class Publisher
        include ROXML
        include Inspector

        xml_name 'Publisher'

        #występuje w tej chwili tylko 01 - główny wydawca
        xml_accessor :role, :from => 'PublishingRole'
        xml_accessor :name, :from => 'PublisherName'

      end

    end
  end
end
