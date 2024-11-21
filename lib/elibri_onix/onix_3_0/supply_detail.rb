module Elibri
  module ONIX
    module Release_3_0
      class SupplyDetail

        attr_accessor :relation_code, :supplier, :product_availability, :pack_quantity, :prices,
                      :on_hand, :quantity_coded, :to_xml, :additional_trade_information

        def initialize(data)
          @to_xml = data.to_s
          @relation_code = data.at_css('ProductRelationCode')&.text&.to_i
          @supplier = Supplier.new(data.at_css('Supplier')) if data.at_css('Supplier')
          @product_availability = data.at_css('ProductAvailability')&.text&.to_i
          @pack_quantity = data.at_css('PackQuantity')&.text&.to_i
          @prices = data.css("Price").map { |p| Price.new(p) }
          if data.at_css('Stock')
            @on_hand = data.at_css('Stock').at_css('OnHand')&.text&.to_i
            @quantity_coded = StockQuantityCoded.new(data.at_css('Stock').at_css('StockQuantityCoded')) if data.at_css('Stock').at_css('StockQuantityCoded')
          end
          if own_coding = data.at_css('SupplierOwnCoding')
            if own_coding.at_css('SupplierCodeType').text == Elibri::ONIX::Dict::Release_3_0::SupplierOwnCodeType::SUPPLIERS_SALES_CLASSIFICATION
              @additional_trade_information = own_coding.at_css('SupplierCodeValue').text
            end
          end
        end

        def quantity_code
          @quantity_coded&.code
        end

      end
    end
  end
end
