

module Elibri
  module ONIX
    module Release_3_0

      class RelatedProduct
        
        #from ONIX documentation:
        #An optional and repeatable group of data elements which together describe a product which has a specified relationship
        #to the product described in the ONIX record.
        include HashId        
 
        #:nodoc:       
        ATTRIBUTES = [
          :relation_code, :proprietary_identifiers, :record_reference
        ]
        
        #:nodoc:
        RELATIONS = [
          :identifiers
        ]
        
        attr_reader :relation_code
        attr_reader :identifiers
        attr_reader :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @relation_code = data.at_css('ProductRelationCode').try(:text)
          @identifiers = data.css('ProductIdentifier').map { |identifier_data| ProductIdentifier.new(identifier_data) }
        end

        
        def record_reference
          @identifiers.find {|identifier| identifier.type == '01' && identifier.type_name == 'elibri' }.try(:value)          
        end


        def proprietary_identifiers
          Hash.new.tap do |hash|
            @identifiers.each do |identifier|
              hash[identifier.type_name] = identifier.value if identifier.type == '01'
            end
          end
        end

      end

    end
  end
end
