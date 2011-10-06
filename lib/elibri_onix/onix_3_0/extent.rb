

module Elibri
  module ONIX
    module Release_3_0

      class Extent
        include ROXML

        xml_name 'Extent'
        xml_accessor :type, :from => 'ExtentType', :as => Fixnum
        xml_accessor :value, :from => 'ExtentValue', :as => BigDecimal
        xml_accessor :unit, :from => 'ExtentUnit', :as => Fixnum
      end

    end
  end
end
