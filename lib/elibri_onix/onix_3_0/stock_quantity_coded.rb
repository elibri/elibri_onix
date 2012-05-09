



module Elibri
  module ONIX
    module Release_3_0

      class StockQuantityCoded
        include ROXML
        include Inspector

        xml_name 'StockQuantityCoded'

        xml_accessor :code_type, :from => 'StockQuantityCodeType', :as => Fixnum
        xml_accessor :code, :from => 'StockQuantityCode'
        
        ATTRIBUTES = [
          :code_type, :code
        ]
        
        RELATIONS = []
        
      end

    end
  end
end
