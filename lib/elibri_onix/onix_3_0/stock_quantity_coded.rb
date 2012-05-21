



module Elibri
  module ONIX
    module Release_3_0

      class StockQuantityCoded
#        include ROXML
#        include Inspector
#
#        xml_name 'StockQuantityCoded'
#
#        xml_accessor :code_type, :from => 'StockQuantityCodeType', :as => Fixnum
#        xml_accessor :code, :from => 'StockQuantityCode'
#        
        ATTRIBUTES = [
          :code_type, :code
        ]
        
        RELATIONS = []
        
        attr_accessor :code_type, :code
        
        def initialize(data)
          @code_type = data.at_xpath('xmlns:StockQuantityCodeType').try(:text).try(:to_i)
          @code = data.at_xpath('xmlns:StockQuantityCode').try(:text)
        end
        
      end

    end
  end
end
