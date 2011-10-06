
module Elibri
  module ONIX
    module Release_3_0

      class AudienceRange
        include ROXML

        xml_name 'AudienceRange'

        xml_accessor :qualifier, :from => 'AudienceRangeQualifier', :as => Fixnum
        xml_accessor :precision, :from => 'AudienceRangePrecision', :as => Fixnum
        xml_accessor :value, :from => 'AudienceRangeValue'


      end

    end
  end
end
