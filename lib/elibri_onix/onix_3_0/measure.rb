

module Elibri
  module ONIX
    module Release_3_0

      class Measure
        include ROXML

        xml_name 'Measure'
        xml_accessor :type, :from => 'MeasureType', :as => Fixnum
        xml_accessor :measurement, :from => 'Measurement', :as => BigDecimal
        xml_accessor :unit, :from => 'MeasureUnitCode'
      end

    end
  end
end
