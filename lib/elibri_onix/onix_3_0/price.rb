



module Elibri
  module ONIX
    module Release_3_0

      class Price
#        include ROXML
#        include Inspector

#        xml_name 'Price'
        
        ATTRIBUTES = [
          :type, :minimum_order_quantity, :amount, :currency_code, :printed_on_product,
          :position_on_product, :tax_type, :tax_rate_percent, :vat
        ]
        
        RELATIONS = []

#        xml_accessor :type, :from => 'PriceType', :as => Fixnum
#        xml_accessor :minimum_order_quantity, :from => 'MinimumOrderQuantity', :as => Fixnum
#        xml_accessor :amount, :from => 'PriceAmount', :as => BigDecimal
#        xml_accessor :currency_code, :from => 'CurrencyCode'
#        xml_accessor :printed_on_product, :from => 'PrintedOnProduct', :as => Fixnum
#        xml_accessor :position_on_product, :from => 'PositionOnProduct', :as => Fixnum

#        xml_accessor :tax_type, :in => 'Tax', :from => 'TaxType', :as => Fixnum
#        xml_accessor :tax_rate_percent, :in => 'Tax', :from => 'TaxRatePercent', :as => BigDecimal
        
        attr_accessor :type, :minimum_order_quantity, :amount, :currency_code, :printed_on_product,
          :position_on_product, :tax_type, :tax_rate_percent

        def initialize(data)
          @type = data.at_xpath('xmlns:PriceType').try(:text).try(:to_i)
          @minimum_order_quantity = data.at_xpath('xmlns:MinimumOrderQuantity').try(:text).try(:to_i)
          @amount = BigDecimal.new(data.at_xpath('xmlns:PriceAmount').try(:text))
          @currency_code = data.at_xpath('xmlns:CurrencyCode').try(:text)
          @printed_on_product = data.at_xpath('xmlns:PrintedOnProduct').try(:text).try(:to_i)
          @position_on_product = data.at_xpath('xmlns:PositionOnProduct').try(:text).try(:to_i)
          if data.at_xpath('xmlns:Tax')
            @tax_type = data.at_xpath('xmlns:Tax').at_xpath('xmlns:TaxType').try(:text).try(:to_i)
            @tax_rate_percent = BigDecimal.new(data.at_xpath('xmlns:Tax').at_xpath('xmlns:TaxRatePercent').try(:text))
          end
        end

        def printed_on_product?
          @printed_on_product == 2
        end


        def vat
          @tax_type == 1 ? @tax_rate_percent : nil
        end

      end

    end
  end
end
