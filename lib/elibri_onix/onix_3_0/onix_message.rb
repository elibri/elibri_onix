
module Elibri
  module ONIX
    module Release_3_0

      class ONIXMessage
        include ROXML
        
        xml_name 'ONIXMessage'
        xml_accessor :release, :from => "@release"

        xml_accessor :products, :as => [Product]
        xml_accessor :header, :as => Header
      end

    end
  end
end
