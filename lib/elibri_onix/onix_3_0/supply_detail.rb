


module Elibri
  module ONIX
    module Release_3_0

      class SupplyDetail
        include ROXML
        include Inspector

        xml_name 'SupplyDetail'

#        xml_accessor :relation_code, :from => 'ProductRelationCode', :as => Fixnum
#        xml_accessor :supplier, :as => Supplier
#        xml_accessor :product_availability, :from => 'ProductAvailability', :as => Fixnum
#        xml_accessor :pack_quantity, :from => 'PackQuantity', :as => Fixnum
#        xml_accessor :price, :as => Price

        
#        xml_accessor :on_hand, :in => 'Stock', :from => 'OnHand', :as => Fixnum
#        xml_accessor :quantity_coded, :in => 'Stock', :as => StockQuantityCoded

        ATTRIBUTES = [
          :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded, :quantity_code
        ]
        
        attr_accessor :relation_code, :supplier, :product_availability, :pack_quantity, :price, :on_hand, :quantity_coded

        RELATIONS = []
        
        def initialize(data)
          @relation_code = data.at_xpath('xmlns:ProductRelationCode').try(:text).try(:to_i)
          @supplier = Supplier.new(data.at_xpath('xmlns:Supplier'))
          @product_availability = data.at_xpath('xmlns:ProductAvailability').try(:text).try(:to_i)
          @pack_quantity = data.at_xpath('xmlns:PackQuantity').try(:text).try(:to_i)
          @price = Price.new(data.at_xpath('xmlns:Price'))
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
