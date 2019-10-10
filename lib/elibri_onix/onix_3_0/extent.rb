

module Elibri
  module ONIX
    module Release_3_0

      class Extent
        
        #from ONIX documentation:
        #covers product extents, in terms of pages, running times, file sizes etc, as may be appropriate to each media type.
        #For products whose content is primarily readable text, it also covers illustrations and other kinds of ancillary matter such as the inclusion of a bibliography or index.
                
        ATTRIBUTES = [
          :type, :value, :unit, :type_name, :unit_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :type, :value, :unit, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.css('ExtentType').try(:text)
          @value = data.css('ExtentValue').try(:text).try(:to_i)
          @unit = data.css('ExtentUnit').try(:text)
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
