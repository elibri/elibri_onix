
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
        
        ATTRIBUTES = [
          :qualifier, :precision, :value
        ]
        
        RELATIONS = []
        
        attr_accessor :qualifier, :precision, :value, :to_xml

        def initialize(data)
          @old_xml = data.to_s
          @qualifier = data.at_xpath('xmlns:AudienceRangeQualifier').try(:text)
          @precision = data.at_xpath('xmlns:AudienceRangePrecision').try(:text)
          @value = data.at_xpath('xmlns:AudienceRangeValue').try(:text).try(:to_i)
        end

        def eid
          "#{@qualifier}-#{@precision}-#{@value}"
        end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end

      end

    end
  end
end
