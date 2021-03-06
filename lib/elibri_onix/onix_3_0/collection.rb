
module Elibri
  module ONIX
    module Release_3_0

      class Collection
        
        include HashId
        
        #from ONIX documentation:
        #A bibliographic collection in ONIX 3.0 means a fixed or indefinite number of products, 
        #published over a fixed or indefinite time period, which share collective attributes (including a collective title) that are
        #required as part of the bibliographic record of each individual product. In this respect,
        #such a collection is most often thought of as a series. A bibliographic collection may,
        #however, also be traded as a single product (often thought of as a set), but this does not alter the way in which
        #its collective attributes are described in the ONIX records for the individual products.
        #set. If a fixed or indefinite number of products have a collective title and   possibly
        #other collective attributes that are required as part of the bibliographic record of each individual product,
        #then those products are regarded as forming a collection.
        #ONIX 3.0 recognises two major types of collection: a publisher collection, and an ascribed collection.
        #A publisher collection is one that is identified either on the products themselves or in product information originating
        #from the publisher. An ascribed collection is one that is identified by another party in the information supply chain,
        #usually an aggregator, for the benefit of retailers and consumers.
        
        ATTRIBUTES = [
          :type, :title_detail, :full_title, :type_name
        ]
        
        RELATIONS = [
          :elements, :inspect_include_fields
        ]
        
        attr_accessor :type, :elements, :title_detail, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('CollectionType').try(:text)
          @elements = data.css('TitleElement').map { |element_data| TitleElement.new(element_data) }
          @title_detail = TitleDetail.new(data.at_css('TitleDetail')) if data.at_css('TitleDetail')
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
