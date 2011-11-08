
module Elibri
  module ONIX
    module Release_3_0

      class Collection
        include ROXML
        include Inspector

        xml_name 'Collection'

        xml_accessor :type, :from => 'CollectionType'
        xml_accessor :elements, :as => [TitleElement]
        xml_accessor :title_detail, :as => TitleDetail

        def full_title
          title_detail.try(:full_title)
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::CollectionType.find_by_onix_code(type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

      end

    end
  end
end
