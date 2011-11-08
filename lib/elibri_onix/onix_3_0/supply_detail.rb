


module Elibri
  module ONIX
    module Release_3_0

      class SupplyDetail
        include ROXML
        include Inspector

        xml_name 'SupplyDetail'

        xml_accessor :relation_code, :from => 'ProductRelationCode', :as => Fixnum
        xml_accessor :supplier, :as => Supplier
        xml_accessor :product_availability, :from => 'ProductAvailability', :as => Fixnum
        xml_accessor :pack_quantity, :from => 'PackQuantity', :as => Fixnum
        xml_accessor :price, :as => Price

        
        xml_accessor :on_hand, :in => 'Stock', :from => 'OnHand', :as => Fixnum
        xml_accessor :quantity_coded, :in => 'Stock', :as => StockQuantityCoded


        def quantity_code
          quantity_coded.try(:code)
        end

      end

    end
  end
end
