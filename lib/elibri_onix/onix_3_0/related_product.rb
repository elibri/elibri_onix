module Elibri
  module ONIX
    module Release_3_0
      class RelatedProduct

        attr_reader :relation_code
        attr_reader :identifiers
        attr_reader :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @relation_code = data.at_css('ProductRelationCode')&.text
          @identifiers = data.css('ProductIdentifier').map { |identifier_data| ProductIdentifier.new(identifier_data) }
        end


        def record_reference
          @identifiers.find {|identifier| identifier.type == '01' && identifier.type_name == 'elibri' }&.value
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
