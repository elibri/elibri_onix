



module Elibri
  module ONIX
    module Release_3_0

      class SupplierIdentifier

        ATTRIBUTES = [
          :type, :type_name, :value
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :type_name, :value, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_xpath('xmlns:SupplierIDType').try(:text)
          @type_name = data.at_xpath('xmlns:IDTypeName').try(:text)
          @value = data.at_xpath('xmlns:IDValue').try(:text)
        end

      end
    end
  end
end
