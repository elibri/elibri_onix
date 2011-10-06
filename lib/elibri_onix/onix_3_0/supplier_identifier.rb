



module Elibri
  module ONIX
    module Release_3_0

      class SupplierIdentifier
        include ROXML

        xml_name 'SupplierIdentifier'

        xml_accessor :type, :from => 'SupplierIDType', :as => Fixnum
        xml_accessor :type_name, :from => 'IDTypeName'
        xml_accessor :value, :from => 'IDValue'


      end
    end
  end
end
