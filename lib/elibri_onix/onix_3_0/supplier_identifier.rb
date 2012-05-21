



module Elibri
  module ONIX
    module Release_3_0

      class SupplierIdentifier
#        include ROXML
#        include Inspector
#
#        xml_name 'SupplierIdentifier'
#
#        xml_accessor :type, :from => 'SupplierIDType', :as => Fixnum
#        xml_accessor :type_name, :from => 'IDTypeName'
#        xml_accessor :value, :from => 'IDValue'

        ATTRIBUTES = [
          :type, :type_name, :value
        ]
        
        RELATIONS = []
        
        attr_accessor :type, :type_name, :value
        
        def initialize(data)
          @type = data.at_xpath('xmlns:SupplierIDType').try(:text)
          @type_name = data.at_xpath('xmlns:IDTypeName').try(:text)
          @value = data.at_xpath('xmlns:IDValue').try(:text)
        end

      end
    end
  end
end
