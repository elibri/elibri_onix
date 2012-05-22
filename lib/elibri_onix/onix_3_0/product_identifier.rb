
module Elibri
  module ONIX
    module Release_3_0

      class ProductIdentifier

        attr_accessor :type, :type_name, :value, :to_xml
        
        ATTRIBUTES = [
          :type, :type_name, :value, :identifier_type
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:ProductIDType').try(:text)
          @type_name = data.at_xpath('xmlns:IDTypeName').try(:text)
          @value = data.at_xpath('xmlns:IDValue').try(:text)
        end

        def identifier_type
          Elibri::ONIX::Dict::Release_3_0::ProductIDType.find_by_onix_code(type).const_name.downcase
        end

        def inspect_include_fields
          [:identifier_type]
        end
      end

    end
  end
end
