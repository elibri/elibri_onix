



module Elibri
  module ONIX
    module Release_3_0

      class RelatedProduct
        include ROXML

        xml_name 'RelatedProduct'

        xml_accessor :relation_code, :from => 'ProductRelationCode', :as => Fixnum
        xml_accessor :identifiers, :as => [ProductIdentifier]


        def isbn13
          identifiers.find {|identifier| identifier.type == 15}.try(:value)
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
