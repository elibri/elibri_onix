


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
          @role = data.at_xpath('xmlns:SupplierRole').try(:text).try(:to_i)
          @identifiers = data.xpath('xmlns:SupplierIdentifier').map { |identifier_data| SupplierIdentifier.new(identifier_data) }
          @name = data.at_xpath('xmlns:SupplierName').try(:text)
          @telephone_number = data.at_xpath('xmlns:TelephoneNumber').try(:text)
          @email_address = data.at_xpath('xmlns:EmailAddress').try(:text)
          if data.at_xpath('xmlns:Website')
            @website = data.at_xpath('xmlns:Website').at_xpath('xmlns:WebsiteLink').try(:text) 
          end
        end

        def nip
          @identifiers.find {|identifier| (identifier.type == '02') && (identifier.type_name == 'NIP')}.try(:value)
        end

      end

    end
  end
end
