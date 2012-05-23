


module Elibri
  module ONIX
    module Release_3_0

      class SupplyDetail
        
        #from ONIX documentation:
        #A group of data elements which together give details of a supply source, and price and availability from that source.
        #Mandatory in each occurrence of the <ProductSupply> block and repeatable.
        

        ATTRIBUTES = [
          :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded, :quantity_code
        ]
        
        attr_accessor :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded, :to_xml

        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @relation_code = data.at_xpath('xmlns:ProductRelationCode').try(:text).try(:to_i)
          @supplier = Supplier.new(data.at_xpath('xmlns:Supplier')) if data.at_xpath('xmlns:Supplier')
          @product_availability = data.at_xpath('xmlns:ProductAvailability').try(:text).try(:to_i)
          @pack_quantity = data.at_xpath('xmlns:PackQuantity').try(:text).try(:to_i)
          @price = Price.new(data.at_xpath('xmlns:Price')) if data.at_xpath('xmlns:Price')
          if data.at_xpath('xmlns:Stock')
            @on_hand = data.at_xpath('xmlns:Stock').at_xpath('xmlns:OnHand').try(:text).try(:to_i)
            @quantity_coded = StockQuantityCoded.new(data.at_xpath('xmlns:Stock').at_xpath('xmlns:StockQuantityCoded')) if data.at_xpath('xmlns:Stock').at_xpath('xmlns:StockQuantityCoded')
          end
        end

        def quantity_code
          @quantity_coded.try(:code)
        end

      end

    end
  end
end
