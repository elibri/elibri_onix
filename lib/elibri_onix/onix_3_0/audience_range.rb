
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
        
        #from ONIX documentation:
        #An optional and repeatable group of data elements which together describe an audience or readership range for which a product
        #is intended.
 
        #:nodoc:       
        ATTRIBUTES = [
          :qualifier, :precision, :value
        ]
        
        #:nodoc:
        RELATIONS = []
        
        attr_reader :qualifier, :precision, :value, :to_xml

        def initialize(data)
          @old_xml = data.to_s
          @qualifier = data.at_css('AudienceRangeQualifier').try(:text)
          @precision = data.at_css('AudienceRangePrecision').try(:text)
          @value = data.at_css('AudienceRangeValue').try(:text).try(:to_i)
        end

      end

    end
  end
end
