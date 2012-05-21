



module Elibri
  module ONIX
    module Release_3_0

      class RelatedProduct
#        include ROXML
#        include Inspector

#        xml_name 'RelatedProduct'

#        xml_accessor :relation_code, :from => 'ProductRelationCode'
#        xml_accessor :identifiers, :as => [ProductIdentifier]
        
        ATTRIBUTES = [
          :relation_code, :proprietary_identifiers, :record_reference
        ]
        
        RELATIONS = [
          :identifiers
        ]
        
        attr_accessor :relation_code, :identifiers
        
        def initialize(data)
          @relation_code = data.at_xpath('//ProductRelationCode').try(:text)
          @identifiers = data.xpath('//ProductIdentifier').map { |identifier_data| ProductIdentifier.new(identifier_data) }
        end

        
        def record_reference
          identifiers.find {|identifier| identifier.type.to_s == '01' && identifier.type_name == 'elibri' }.try(:value)          
        end


        def proprietary_identifiers
          Hash.new.tap do |hash|
            identifiers.each do |identifier|
              hash[identifier.type_name] = identifier.value if identifier.type == '01'
            end
          end
        end

      end

    end
  end
end
