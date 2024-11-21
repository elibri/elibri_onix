module Elibri
  module ONIX
    module Release_3_0
      class PriceConstraintLimit

        attr_accessor :unit, :value, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @unit = data.at_css('PriceConstraintUnit')&.text
          @value = data.at_css("Quantity")&.text
          if @unit == Elibri::ONIX::Dict::Release_3_0::PriceConstraintUnit::VALID_FROM
            @value = Date.new(@value[0...4].to_i, @value[4...6].to_i, @value[6...8].to_i)
          else
            @value = @value.to_i
          end
        end

      end
    end
  end
end
