module Elibri
  module ONIX
    module Release_3_0
      class SalesRestriction

        attr_accessor :type, :outlet_name, :outlet_code, :end_date, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('SalesRestrictionType')&.text&.to_i
          if data.at_css('SalesOutlet')
            @outlet_name = data.at_css('SalesOutlet').at_css('SalesOutletName')&.text
            outlet_id_struct = data.at_css('SalesOutlet').at_css('SalesOutletIdentifier')
            if outlet_id_struct && outlet_id_struct.at_css("SalesOutletIDType")&.text == "03"
              @outlet_code = outlet_id_struct.at_css("IDValue")&.text
            end
          end
          @end_date = Date.parse(data.at_css('EndDate')&.text) if data.at_css('EndDate')
        end

      end
    end
  end
end
