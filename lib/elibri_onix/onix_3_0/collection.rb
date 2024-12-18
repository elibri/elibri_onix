module Elibri
  module ONIX
    module Release_3_0
      class Collection

        attr_accessor :type, :elements, :title_detail, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('CollectionType')&.text
          @elements = data.css('TitleElement').map { |element_data| TitleElement.new(element_data) }
          @title_detail = TitleDetail.new(data.at_css('TitleDetail')) if data.at_css('TitleDetail')
        end

        def full_title
          title_detail&.full_title
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::CollectionType.find_by_onix_code(@type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

      end
    end
  end
end
