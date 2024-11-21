module Elibri
  module ONIX
    module Release_3_0
      class ThemaSubject

        attr_accessor :code, :heading_text, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @code = data.at_css('SubjectCode')&.text
          @heading_text = data.at_css('SubjectHeadingText')&.text
        end

        def inspect_include_fields
          [:code]
        end
      end
    end
  end
end
