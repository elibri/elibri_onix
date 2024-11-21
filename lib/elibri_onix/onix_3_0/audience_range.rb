module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange

        attr_reader :qualifier, :precision, :value, :to_xml

        def initialize(data)
          @old_xml = data.to_s
          @qualifier = data.at_css('AudienceRangeQualifier')&.text
          @precision = data.at_css('AudienceRangePrecision')&.text
          @value = data.at_css('AudienceRangeValue')&.text&.to_i
        end

      end

    end
  end
end
