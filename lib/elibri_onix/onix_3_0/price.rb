



module Elibri
  module ONIX
    module Release_3_0

      class Price
        include ROXML

        xml_name 'Price'

        xml_accessor :type, :from => 'PriceType', :as => Fixnum
        xml_accessor :minimum_order_quantity, :from => 'MinimumOrderQuantity', :as => Fixnum
        xml_accessor :amount, :from => 'PriceAmount', :as => BigDecimal
        xml_accessor :currency_code, :from => 'CurrencyCode'
        xml_accessor :printed_on_product, :from => 'PrintedOnProduct', :as => Fixnum
        xml_accessor :position_on_product, :from => 'PositionOnProduct', :as => Fixnum

        with_options :in => 'Tax' do |tax|
          tax.xml_accessor :tax_type, :from => 'TaxType', :as => Fixnum
          tax.xml_accessor :tax_rate_percent, :from => 'TaxRatePercent', :as => BigDecimal
        end


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
