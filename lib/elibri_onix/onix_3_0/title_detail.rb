

module Elibri
  module ONIX
    module Release_3_0

      class TitleDetail
        include ROXML
        include Inspector

        xml_name 'TitleDetail'

        xml_accessor :type, :from => 'TitleType'
        xml_accessor :elements, :as => [TitleElement]
        
        ATTRIBUTES = [
          :type, :type_name, :full_title, :product_level_title, :product_level, :collection_level_title,
          :collection_level
        ]
        
        RELATIONS = [
          :elements, :inspect_include_fields
        ]

        def id
          type.to_i
        end 

        def type_name
           Elibri::ONIX::Dict::Release_3_0::TitleType.find_by_onix_code(self.type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

        def full_title
          String.new.tap do |_full_title|
            _full_title << collection_level_title if collection_level_title.present?
            if product_level_title.present?
              _full_title << ". " if _full_title.present?
              _full_title << product_level_title 
            end
          end
        end

        def product_level_title
          product_level.try(:full_title)
        end

        def product_level
          elements.find {|element| element.level == "01"}
        end

        def collection_level_title
          collection_level.try(:full_title)
        end

        def collection_level
          elements.find {|element| element.level == "02"}
        end

      end

    end
  end
end
