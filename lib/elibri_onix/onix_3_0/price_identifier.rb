module Elibri
  module ONIX
    module Release_3_0
      class PriceIdentifier

        attr_accessor :type, :type_name, :value, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('PriceIDType')&.text
          @type_name = data.at_css("IDTypeName")&.text
          @value = data.at_css("IDValue")&.text
        end

      end
    end
  end
end
