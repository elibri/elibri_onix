


module Elibri
  module ONIX
    module Release_3_0

      class Supplier
        include ROXML

        xml_name 'Supplier'

        xml_accessor :role, :from => 'SupplierRole', :as => Fixnum
        xml_accessor :identifiers, :as => [SupplierIdentifier]
        xml_accessor :name, :from => 'SupplierName'
        xml_accessor :telephone_number, :from => 'TelephoneNumber'
        xml_accessor :email_address, :from => 'EmailAddress'
        xml_accessor :website, :from => 'WebsiteLink', :in => 'Website'


        def nip
          identifiers.find {|identifier| (identifier.type == 2) && (identifier.type_name == 'NIP')}.try(:value)
        end

      end

    end
  end
end
