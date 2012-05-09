

module Elibri
  module ONIX
    module Release_3_0

      class Measure
        include ROXML
        include Inspector

        xml_name 'Measure'
        xml_accessor :type, :from => 'MeasureType'
        xml_accessor :measurement, :from => 'Measurement', :as => Fixnum
        xml_accessor :unit, :from => 'MeasureUnitCode'
        
        ATTRIBUTES = [
          :type, :from, :measurement, :unit, :type_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]

        def type_name
           Elibri::ONIX::Dict::Release_3_0::MeasureType.find_by_onix_code(type).const_name.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

      end

    end
  end
end
