
module Elibri
  module ONIX
    module Release_3_0

      class ProductIdentifier
#        include ROXML
#        include Inspector

#        xml_name 'ProductIdentifier'
#        xml_accessor :type, :from => 'ProductIDType'
#        xml_accessor :type_name, :from => 'IDTypeName'
#        xml_accessor :value, :from => 'IDValue'

        attr_accessor :type, :type_name, :value
        
        ATTRIBUTES = [
          :type, :type_name, :value, :identifier_type
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        def initialize(data)
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
