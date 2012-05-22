


module Elibri
  module ONIX
    module Release_3_0

      class SalesRestriction
        
        ATTRIBUTES = [
          :type, :outlet_name, :end_date
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :outlet_name, :end_date, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:SalesRestrictionType').try(:text).try(:to_i)
          if data.at_xpath('xmlns:SalesOutlet')
            @outlet_name = data.at_xpath('xmlns:SalesOutlet').at_xpath('xmlns:SalesOutletName').try(:text)
          end
          @end_date = Date.parse(data.at_xpath('xmlns:EndDate').try(:text)) if data.at_xpath('xmlns:EndDate')
        end

      end

    end
  end
end
