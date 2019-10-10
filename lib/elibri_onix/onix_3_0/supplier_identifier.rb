



module Elibri
  module ONIX
    module Release_3_0

      class SupplierIdentifier
        
        #from ONIX documentation:
        #A repeatable group of data elements which together define the identifier of a supplier in accordance with a specified scheme,
        #and allowing different types of supplier identifier to be included without defining additional data elements.
        #Optional, but each occurrence of the <Supplier> composite must carry either at least one supplier identifier,
        #or a <SupplierName>, or both.
       
       include HashId 

        ATTRIBUTES = [
          :type, :type_name, :value
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :type_name, :value, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('SupplierIDType').try(:text)
          @type_name = data.at_css('IDTypeName').try(:text)
          @value = data.at_css('IDValue').try(:text)
        end

      end
    end
  end
end
