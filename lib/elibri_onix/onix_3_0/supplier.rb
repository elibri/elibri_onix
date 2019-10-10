


module Elibri
  module ONIX
    module Release_3_0

      class Supplier
        
        #from ONIX documentation:
        #A group of data elements which together define a supplier. Mandatory in each occurrence of the <SupplyDetail> composite, and not repeatable.

        ATTRIBUTES = [
          :role, :name, :telephone_number, :email_address, :website, :nip
        ]
        
        RELATIONS = [
          :identifiers
        ]
        
        include HashId
        
        attr_accessor :role, :identifiers, :name, :telephone_number, :email_address, :website, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('SupplierRole').try(:text)
          @identifiers = data.css('SupplierIdentifier').map { |identifier_data| SupplierIdentifier.new(identifier_data) }
          @name = data.at_css('SupplierName').try(:text)
          @telephone_number = data.at_css('TelephoneNumber').try(:text)
          @email_address = data.at_css('EmailAddress').try(:text)
          if data.at_css('Website')
            @website = data.at_css('Website').at_css('WebsiteLink').try(:text) 
          end
        end

        def nip
          @identifiers.find {|identifier| (identifier.type == '02') && (identifier.type_name == 'NIP')}.try(:value)
        end

      end

    end
  end
end
