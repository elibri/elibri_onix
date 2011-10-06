
module Elibri
  module ONIX
    module Release_3_0

      class ProductIdentifier
        include ROXML

        xml_name 'ProductIdentifier'
        xml_accessor :type, :as => Fixnum, :from => 'ProductIDType'
        xml_accessor :type_name, :from => 'IDTypeName'
        xml_accessor :value, :from => 'IDValue'
      end

    end
  end
end