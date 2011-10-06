
module Elibri
  module ONIX
    module Release_3_0

      class Collection
        include ROXML

        xml_name 'Collection'

        xml_accessor :type, :from => 'CollectionType', :as => Fixnum
        xml_accessor :elements, :as => [TitleElement]
        xml_accessor :title_detail, :as => TitleDetail

        def full_title
          title_detail.try(:full_title)
        end

      end

    end
  end
end
