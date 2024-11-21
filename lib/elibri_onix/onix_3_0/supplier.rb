module Elibri
  module ONIX
    module Release_3_0
      class Supplier

        attr_accessor :role, :identifiers, :name, :telephone_number, :email_address, :website, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('SupplierRole')&.text
          @identifiers = data.css('SupplierIdentifier').map { |identifier_data| SupplierIdentifier.new(identifier_data) }
          @name = data.at_css('SupplierName')&.text
          @telephone_number = data.at_css('TelephoneNumber')&.text
          @email_address = data.at_css('EmailAddress')&.text
          if data.at_css('Website')
            @website = data.at_css('Website').at_css('WebsiteLink')&.text
          end
        end

        def nip
          @identifiers.find {|identifier| (identifier.type == '02') && (identifier.type_name == 'NIP')}&.value
        end

      end
    end
  end
end
