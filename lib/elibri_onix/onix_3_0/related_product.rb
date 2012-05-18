



module Elibri
  module ONIX
    module Release_3_0

      class RelatedProduct
        include ROXML
        include Inspector

        xml_name 'RelatedProduct'

        xml_accessor :relation_code, :from => 'ProductRelationCode'
        xml_accessor :identifiers, :as => [ProductIdentifier]
        
        ATTRIBUTES = [
          :relation_code, :isbn13, :proprietary_identifiers, :record_reference
        ]
        
        RELATIONS = [
          :identifiers
        ]
        


        def isbn13
          identifiers.find {|identifier| identifier.type == 15}.try(:value)
        end

        
        def record_reference
          identifiers.find {|identifier| identifier.type.to_s == '01' && identifier.type_name == 'elibri' }.try(:value)          
        end


        def proprietary_identifiers
          Hash.new.tap do |hash|
            identifiers.each do |identifier|
              hash[identifier.type_name] = identifier.value if identifier.type == 1
            end
          end
        end

      end

    end
  end
end
