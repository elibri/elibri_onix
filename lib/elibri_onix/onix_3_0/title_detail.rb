module Elibri
  module ONIX
    module Release_3_0
      class TitleDetail

        attr_accessor :type, :elements, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('TitleType')&.text
          @elements = data.css('TitleElement').map { |element_data| TitleElement.new(element_data) }
        end

        def type_name
           Elibri::ONIX::Dict::Release_3_0::TitleType.find_by_onix_code(self.type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

        def full_title
          String.new.tap do |_full_title|
            _full_title << collection_level_title if collection_level_title && collection_level_title.size > 0
            if product_level_title && product_level_title.size > 0
              _full_title << ". " if _full_title && _full_title.size > 0
              _full_title << product_level_title
            end
          end
        end

        def product_level_title
          product_level&.full_title
        end

        def product_level
          @elements.find {|element| element.level == "01"}
        end

        def collection_level_title
          collection_level&.full_title
        end

        def collection_level
          @elements.find {|element| element.level == "02"}
        end

      end

    end
  end
end
