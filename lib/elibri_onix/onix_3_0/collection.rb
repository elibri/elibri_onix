
module Elibri
  module ONIX
    module Release_3_0

      class Collection
        
        ATTRIBUTES = [
          :type, :title_detail, :full_title, :type_name
        ]
        
        RELATIONS = [
          :elements, :inspect_include_fields
        ]
        
        attr_accessor :type, :elements, :title_detail, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:CollectionType').try(:text)
          @elements = data.xpath('xmlns:TitleElement').map { |element_data| TitleElement.new(element_data) }
          @title_detail = TitleDetail.new(data.at_xpath('xmlns:TitleDetail'))
        end

        def full_title
          title_detail.try(:full_title)
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
