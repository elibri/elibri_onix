


module Elibri
  module ONIX
    module Release_3_0

      class SalesRestriction

        #from ONIX documentation:        
        #A group of data elements which together identify a non-territorial sales restriction which a publisher applies to a product.
        #Optional and repeatable.

        include HashId
        
        ATTRIBUTES = [
          :type, :outlet_name, :end_date
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :outlet_name, :end_date, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('SalesRestrictionType').try(:text).try(:to_i)
          if data.at_css('SalesOutlet')
            @outlet_name = data.at_css('SalesOutlet').at_css('SalesOutletName').try(:text)
          end
          @end_date = Date.parse(data.at_css('EndDate').try(:text)) if data.at_css('EndDate')
        end

      end

    end
  end
end
