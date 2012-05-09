
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
        include ROXML
        include Inspector

        xml_name 'AudienceRange'
        
        ATTRIBUTES = [
          :qualifier, :precision, :value
        ]
        
        RELATIONS = []

        xml_accessor :qualifier, :from => 'AudienceRangeQualifier'
        xml_accessor :precision, :from => 'AudienceRangePrecision'
        xml_accessor :value, :from => 'AudienceRangeValue', :as => Fixnum


      end

    end
  end
end
