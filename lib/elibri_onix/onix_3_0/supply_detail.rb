


module Elibri
  module ONIX
    module Release_3_0

      class SupplyDetail
        
        #from ONIX documentation:
        #A group of data elements which together give details of a supply source, and price and availability from that source.
        #Mandatory in each occurrence of the <ProductSupply> block and repeatable.

        include HashId
        

        ATTRIBUTES = [
          :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded, :quantity_code, :additional_trade_information
        ]
        
        attr_accessor :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded, :to_xml, :additional_trade_information

        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @relation_code = data.at_css('ProductRelationCode').try(:text).try(:to_i)
          @supplier = Supplier.new(data.at_css('Supplier')) if data.at_css('Supplier')
          @product_availability = data.at_css('ProductAvailability').try(:text).try(:to_i)
          @pack_quantity = data.at_css('PackQuantity').try(:text).try(:to_i)
          @price = Price.new(data.at_css('Price')) if data.at_css('Price')
          if data.at_css('Stock')
            @on_hand = data.at_css('Stock').at_css('OnHand').try(:text).try(:to_i)
            @quantity_coded = StockQuantityCoded.new(data.at_css('Stock').at_css('StockQuantityCoded')) if data.at_css('Stock').at_css('StockQuantityCoded')
          end
          if own_coding = data.at_css('SupplierOwnCoding')
            if own_coding.at_css('SupplierCodeType').text == Elibri::ONIX::Dict::Release_3_0::SupplierOwnCodeType::SUPPLIERS_SALES_CLASSIFICATION
              @additional_trade_information = own_coding.at_css('SupplierCodeValue').text 
            end
          end
        end

        def quantity_code
          @quantity_coded.try(:code)
        end

      end

    end
  end
end
