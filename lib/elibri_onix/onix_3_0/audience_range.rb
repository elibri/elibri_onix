
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
        include ROXML
        include Inspector

        xml_name 'AudienceRange'

        xml_accessor :qualifier, :from => 'AudienceRangeQualifier'
        xml_accessor :precision, :from => 'AudienceRangePrecision'
        xml_accessor :value, :from => 'AudienceRangeValue', :as => Fixnum

        def id
          "#{qualifier}-#{precision}-#{value}"
        end

      end

    end
  end
end
