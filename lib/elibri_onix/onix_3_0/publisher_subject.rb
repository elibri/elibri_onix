
module Elibri
  module ONIX
    module Release_3_0

      class PublisherSubject

        include HashId

        ATTRIBUTES = [
          :code, :heading_text
        ]

        RELATIONS = [
          :inspect_include_fields
        ]

        attr_accessor :code, :heading_text, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @code = data.at_css('SubjectCode').try(:text)
          @heading_text = data.at_css('SubjectHeadingText').try(:text)
        end

        def inspect_include_fields
          [:code]
        end
      end
    end
  end
end
