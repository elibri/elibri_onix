module Elibri
  module ONIX
    module Release_3_0
      class Extent

        attr_accessor :type, :value, :unit, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.css('ExtentType')&.text&.strip
          @value = data.css('ExtentValue')&.text&.strip&.to_i
          @unit = data.css('ExtentUnit')&.text&.strip
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::ExtentType.find_by_onix_code(@type)&.const_name&.downcase
        end

        def unit_name
          Elibri::ONIX::Dict::Release_3_0::ExtentUnit.find_by_onix_code(@unit)&.const_name&.downcase
        end

        def inspect_include_fields
          [:type_name, :unit_name]
        end

      end

    end
  end
end
