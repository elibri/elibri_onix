


module Elibri
  module ONIX
    module Release_3_0

      class Publisher
        include ROXML
        include Inspector

        xml_name 'Publisher'

        xml_accessor :role, :from => 'PublishingRole', :as => Fixnum
        xml_accessor :name, :from => 'PublisherName'

      end

    end
  end
end
