module Elibri
  module ONIX
    module Release_3_0

      class StockQuantityCoded
        
        #from ONIX documentation:
        #A group of data elements which together specify coded stock level without stating the exact quantity of stock.
        #Either <StockQuantityCoded> or <OnHand> is mandatory in each occurrence of the <Stock> composite, even if 
        #the quantity on hand is zero. Non-repeating.

        include HashId

        ATTRIBUTES = [
          :code_type, :code
        ]
        
        RELATIONS = []
        
        attr_accessor :code_type, :code, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @code_type = data.at_xpath('xmlns:StockQuantityCodeType').try(:text).try(:to_i)
          @code = data.at_xpath('xmlns:StockQuantityCode').try(:text)
        end
        
      end

    end
  end
end
