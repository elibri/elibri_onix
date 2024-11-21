module Elibri
  module ONIX
    module Release_3_0
      class ProductIdentifier

        #onix code of type (see elibri_onix_dict, Elibri::ONIX::Dict::Release_3_0::ProductIDType)
        attr_accessor :type

        #if type is prioprietery (01) - then the name of type
        attr_accessor :type_name

        #identifier value
        attr_accessor :value

        #xml representation of identifier
        attr_accessor :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('ProductIDType')&.text
          @type_name = data.at_css('IDTypeName')&.text
          @value = data.at_css('IDValue')&.text
        end

        #returs the string name of value type
        def identifier_type
          Elibri::ONIX::Dict::Release_3_0::ProductIDType.find_by_onix_code(@type)&.const_name&.downcase
        end

        #:nodoc:
        def inspect_include_fields
          [:identifier_type]
        end
      end
    end
  end
end
