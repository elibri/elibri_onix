module Elibri
  module ONIX
    module Release_3_0

      class Price

        attr_accessor :type, :minimum_order_quantity, :amount, :currency_code, :printed_on_product, :price_identifier,
          :position_on_product, :tax_type, :tax_rate_percent, :price_qualifier, :price_constraint_limits, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('PriceType')&.text
          @price_qualifier = data.at_css("PriceQualifier")&.text
          @minimum_order_quantity = data.at_css('MinimumOrderQuantity')&.text&.to_i
          @amount = BigDecimal(data.at_css('PriceAmount')&.text)
          @currency_code = data.at_css('CurrencyCode')&.text
          @printed_on_product = data.at_css('PrintedOnProduct')&.text
          @position_on_product = data.at_css('PositionOnProduct')&.text
          if data.at_css('Tax')
            @tax_type = data.at_css('Tax').at_css('TaxType')&.text
            @tax_rate_percent = data.at_css('Tax').at_css('TaxRatePercent').text.to_i if data.at_css('Tax').at_css('TaxRatePercent')
          end
          @price_constraint_limits = data.css("PriceConstraintLimit").map { |pc| PriceConstraintLimit.new(pc) }
          if pi = data.at_css("PriceIdentifier")
            @price_identifier = PriceIdentifier.new(pi)
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
