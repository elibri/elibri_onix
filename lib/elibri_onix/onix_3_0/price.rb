



module Elibri
  module ONIX
    module Release_3_0

      class Price
        include ROXML
        include Inspector

        xml_name 'Price'

        xml_accessor :type, :from => 'PriceType', :as => Fixnum
        xml_accessor :minimum_order_quantity, :from => 'MinimumOrderQuantity', :as => Fixnum
        xml_accessor :amount, :from => 'PriceAmount', :as => BigDecimal
        xml_accessor :currency_code, :from => 'CurrencyCode'
        xml_accessor :printed_on_product, :from => 'PrintedOnProduct', :as => Fixnum
        xml_accessor :position_on_product, :from => 'PositionOnProduct', :as => Fixnum

        xml_accessor :tax_type, :in => 'Tax', :from => 'TaxType', :as => Fixnum
        xml_accessor :tax_rate_percent, :in => 'Tax', :from => 'TaxRatePercent', :as => BigDecimal


        def printed_on_product?
          printed_on_product == 2
        end


        def vat
          tax_type == 1 ? tax_rate_percent : nil
        end

      end

    end
  end
end
