module Elibri
  module ONIX
    module Release_3_0
      class Measure

        attr_accessor :type, :measurement, :unit, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('MeasureType')&.text
          @measurement = data.at_css('Measurement')&.text&.to_i
          @unit = data.at_css('MeasureUnitCode')&.text

        end

        def type_name
           Elibri::ONIX::Dict::Release_3_0::MeasureType.find_by_onix_code(@type)&.const_name&.downcase
        end

        def inspect_include_fields
          [:type_name]
        end

      end
    end
  end
end
