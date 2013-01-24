
module Elibri
  module ONIX
    module Release_3_0
      
      #klasa abstahuje parsowanie wymiarów książki.
      class Measure
        
        include HashId
        
        ATTRIBUTES = [
          :type, :measurement, :unit, :type_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :type, :measurement, :unit, :type_name, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:MeasureType').try(:text)
          @measurement = data.at_xpath('xmlns:Measurement').try(:text).try(:to_i)
          @unit = data.at_xpath('xmlns:MeasureUnitCode').try(:text)
          
        end

        def type_name
           Elibri::ONIX::Dict::Release_3_0::MeasureType.find_by_onix_code(@type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

  #      def eid
  #        @type.to_i
  #      end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end

      end

    end
  end
end
