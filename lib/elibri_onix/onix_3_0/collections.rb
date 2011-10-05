
module Elibri
  module ONIX
    module Release_3_0

      class Collection
        include ROXML

        xml_name 'TitleDetail'

        xml_accessor :type, :from => 'CollectionType', :as => Fixnum
        xml_accessor :elements, :as => [TitleElement]
        xml_accessor :title_details, :as => [TitleDetail]
      end

    end
  end
end
