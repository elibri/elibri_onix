

module Elibri
  module ONIX
    module Release_3_0

      class TitleDetail
        
        #from ONIX documentation:
        #A repeatable group of data elements which together give the text of a collection title and specify its type.
        #Optional, but the composite is required unless the collection title is carried in full, and word-for- word,
        #as an integral part of the product title in P.6, in which case it should not be repeated in P.5.
        
        include HashId        
        
        ATTRIBUTES = [
          :type, :type_name, :full_title, :product_level_title, :product_level, :collection_level_title,
          :collection_level
        ]
        
        RELATIONS = [
          :elements, :inspect_include_fields
        ]
        
        attr_accessor :type, :elements, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:TitleType').try(:text)
          @elements = data.xpath('xmlns:TitleElement').map { |element_data| TitleElement.new(element_data) }
        end

    #    def eid
    #      @type.to_i
    #    end 
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
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
          @elements.find {|element| element.level == "01"}
        end

        def collection_level_title
          collection_level.try(:full_title)
        end

        def collection_level
          @elements.find {|element| element.level == "02"}
        end

      end

    end
  end
end
