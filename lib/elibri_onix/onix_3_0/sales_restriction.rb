


module Elibri
  module ONIX
    module Release_3_0

      class SalesRestriction
        include ROXML
        include Inspector

        xml_name 'SalesRestriction'

        xml_accessor :type, :from => 'SalesRestrictionType', :as => Fixnum
        xml_accessor :outlet_name, :from => 'SalesOutletName', :in => 'SalesOutlet'
        xml_accessor :end_date, :from => 'EndDate', :as => Date
        
        ATTRIBUTES = [
          :type, :outlet_name, :end_date
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :outlet_name, :end_date
        
        def initialize(data)
          @type = data.at_xpath('xmlns:SalesRestrictionType').try(:text).try(:to_i)
          if data.at_xpath('xmlns:SalesOutlet')
            @outlet_name = data.at_xpath('xmlns:SalesOutlet').at_xpath('xmlns:SalesOutletName').try(:text)
          end
          @end_date = Date.parse(data.at_xpath('xmlns:EndDate').try(:text))
        end

      end

    end
  end
end
