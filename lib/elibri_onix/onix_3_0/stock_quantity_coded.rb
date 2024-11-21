module Elibri
  module ONIX
    module Release_3_0
      class StockQuantityCoded

        attr_accessor :code_type, :code, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @code_type = data.at_css('StockQuantityCodeType')&.text&.to_i
          @code = data.at_css('StockQuantityCode')&.text
        end

      end
    end
  end
end
