



module Elibri
  module ONIX
    module Release_3_0

      class Price

        #from ONIX documentation:
        #A repeatable group of data elements which together specify a unit price.

                include HashId

        ATTRIBUTES = [
          :type, :minimum_order_quantity, :amount, :currency_code, :printed_on_product,
          :position_on_product, :tax_type, :tax_rate_percent, :vat
        ]

        RELATIONS = []

        attr_accessor :type, :minimum_order_quantity, :amount, :currency_code, :printed_on_product,
          :position_on_product, :tax_type, :tax_rate_percent, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('PriceType').try(:text)
          @minimum_order_quantity = data.at_css('MinimumOrderQuantity').try(:text).try(:to_i)
          @amount = BigDecimal(data.at_css('PriceAmount').try(:text))
          @currency_code = data.at_css('CurrencyCode').try(:text)
          @printed_on_product = data.at_css('PrintedOnProduct').try(:text)
          @position_on_product = data.at_css('PositionOnProduct').try(:text)
          if data.at_css('Tax')
            @tax_type = data.at_css('Tax').at_css('TaxType').try(:text)
            @tax_rate_percent = data.at_css('Tax').at_css('TaxRatePercent').text.to_i if data.at_css('Tax').at_css('TaxRatePercent')
          end
        end

        def printed_on_product?
          @printed_on_product == "02"
        end


        def vat
          @tax_type == Elibri::ONIX::Dict::Release_3_0::TaxType::VAT ? @tax_rate_percent : nil
        end

      end

    end
  end
end
