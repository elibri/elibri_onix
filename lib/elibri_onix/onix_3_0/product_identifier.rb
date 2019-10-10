
module Elibri
  module ONIX
    module Release_3_0

      #product identifier, for example isbn
      class ProductIdentifier
        
        include HashId

        #onix code of type (see elibri_onix_dict, Elibri::ONIX::Dict::Release_3_0::ProductIDType)
        attr_accessor :type

        #if type is prioprietery (01) - then the name of type
        attr_accessor :type_name
  
        #identifier value
        attr_accessor :value

        #xml representation of identifier
        attr_accessor :to_xml
        
        #:nodoc:
        ATTRIBUTES = [
          :type, :type_name, :value, :identifier_type
        ]
        
        #:nodoc:
        RELATIONS = [
          :inspect_include_fields
        ]
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('ProductIDType').try(:text)
          @type_name = data.at_css('IDTypeName').try(:text)
          @value = data.at_css('IDValue').try(:text)
        end

        #returs the string name of value type
        def identifier_type
          Elibri::ONIX::Dict::Release_3_0::ProductIDType.find_by_onix_code(@type).const_name.downcase
        end

        #:nodoc:
        def inspect_include_fields
          [:identifier_type]
        end
      end

    end
  end
end
