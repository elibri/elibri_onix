
module Elibri
  module ONIX
    module Release_3_0

      class TextContent
        include ROXML
        include Inspector
        include ExternalId
        include ExternalTimestamp

        xml_name 'TextContent'

        xml_accessor :type, :from => 'TextType'
        #xml_accessor :audience, :from => 'ContentAudience' - always unrestricted
        xml_accessor :author, :from => 'TextAuthor'

        xml_accessor :text, :from => 'Text', :cdata => true

        def type_name
          Elibri::ONIX::Dict::Release_3_0::OtherTextType.find_by_onix_code(type).const_name.downcase
        end
 
        def inspect_include_fields
          [:type_name]
        end

        private
          def after_parse
            @text = @text.strip if @text
          end
      end

    end
  end
end
