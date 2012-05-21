

module Elibri
  module ONIX
    module Release_3_0

      class Extent
#        include ROXML
#        include Inspector
#
#        xml_name 'Extent'
#        xml_accessor :type, :from => 'ExtentType'
#        xml_accessor :value, :from => 'ExtentValue', :as => Fixnum
#        xml_accessor :unit, :from => 'ExtentUnit'
#        
        ATTRIBUTES = [
          :type, :value, :unit, :type_name, :unit_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :type, :value, :unit
        
        def initialize(data)
          @type = data.xpath('xmlns:ExtentType').try(:text)
          @value = data.xpath('xmlns:ExtentValue').try(:text).try(:to_i)
          @unit = data.xpath('xmlns:ExtentUnit').try(:text)
        end

        def id
          type.to_i
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::ExtentType.find_by_onix_code(@type).const_name.downcase
        end
 
        def unit_name
          Elibri::ONIX::Dict::Release_3_0::ExtentUnit.find_by_onix_code(@unit).const_name.downcase
        end

        def inspect_include_fields
          [:type_name, :unit_name]
        end
    
      end

    end
  end
end
