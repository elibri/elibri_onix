


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

      end

    end
  end
end
