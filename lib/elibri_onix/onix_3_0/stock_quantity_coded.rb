



module Elibri
  module ONIX
    module Release_3_0

      class StockQuantityCoded
        include ROXML

        xml_name 'StockQuantityCoded'

        xml_accessor :code_type, :from => 'StockQuantityCodeType', :as => Fixnum
        xml_accessor :code, :from => 'StockQuantityCode'
        
      end

    end
  end
end
