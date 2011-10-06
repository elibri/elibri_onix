
module Elibri
  module ONIX
    module Release_3_0

      class TextContent
        include ROXML

        xml_name 'TextContent'

        xml_accessor :type, :from => 'TextType', :as => Fixnum
        xml_accessor :audience, :from => 'ContentAudience', :as => Fixnum
        xml_accessor :author, :from => 'TextAuthor'

        xml_accessor :text, :from => 'Text', :cdata => true

      end

    end
  end
end
