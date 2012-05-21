


module Elibri
  module ONIX
    module Release_3_0

      class Supplier
#        include ROXML
#        include Inspector

#        xml_name 'Supplier'

#        xml_accessor :role, :from => 'SupplierRole', :as => Fixnum
#        xml_accessor :identifiers, :as => [SupplierIdentifier]
#        xml_accessor :name, :from => 'SupplierName'
#        xml_accessor :telephone_number, :from => 'TelephoneNumber'
#        xml_accessor :email_address, :from => 'EmailAddress'
#        xml_accessor :website, :from => 'WebsiteLink', :in => 'Website'

        ATTRIBUTES = [
          :role, :name, :telephone_number, :email_address, :website, :nip
        ]
        
        RELATIONS = [
          :identifiers
        ]
        
        attr_accessor :role, :identifiers, :name, :telephone_number, :email_address, :website
        
        def initializer(data)
          @role = data.at_xpath('xmlns:SupplierRole').try(:text).try(:to_i)
          @identifiers = data.xpath('xmlns:SupplierIdentifier').map { |identifier_data| SupplierIdentifier.new(identifier_data) }
          @name = data.at_xpath('xmlns:SupplierName').try(:text)
          @telephone_number = data.at_xpath('xmlns:TelephoneNumber').try(:text)
          @email_address = data.at_xpath('xmlns:EmailAddress').try(:text)
          debugger
          @website = data.at_xpath('xmlns:Website').try(:text)
        end

        def nip
          identifiers.find {|identifier| (identifier.type == '02') && (identifier.type_name == 'NIP')}.try(:value)
        end

      end

    end
  end
end
