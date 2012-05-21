
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
#        include ROXML
#        include Inspector

#        xml_name 'AudienceRange'
        
        ATTRIBUTES = [
          :qualifier, :precision, :value
        ]
        
        RELATIONS = []

#        xml_accessor :qualifier, :from => 'AudienceRangeQualifier'
#        xml_accessor :precision, :from => 'AudienceRangePrecision'
#        xml_accessor :value, :from => 'AudienceRangeValue', :as => Fixnum
        
        attr_accessor :qualifier, :precision, :value

        def initialize(data)
          @qualifier = data.at_xpath('xmlns:AudienceRangeQualifier').try(:text)
          @precision = data.at_xpath('xmlns:AudienceRangePrecision').try(:text)
          @value = data.at_xpath('xmlns:AudienceRangeValue').try(:text).try(:to_i)
        end

        def id
          "#{qualifier}-#{precision}-#{value}"
        end

      end

    end
  end
end
