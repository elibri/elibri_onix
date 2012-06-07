

module Elibri
  module ONIX
    module Release_3_0

      class Subject
        
        #from ONIX documentation:
        #An optional and repeatable group of data elements which together specify a subject classification or subject heading.

        include HashId

        
        ATTRIBUTES = [
          :scheme_identifier, :scheme_name, :scheme_version, :code, :heading_text, :main_subject
        ]
        
        attr_accessor :scheme_identifier, :scheme_name, :scheme_version, :code, :heading_text, :main_subject, :to_xml
        
        RELATIONS = []
        
        def initialize(data)
          @to_xml = data.to_s
          @scheme_identifier = data.xpath('xmlns:SubjectSchemeIdentifier').try(:text).try(:to_i)
          @scheme_name = data.xpath('xmlns:SubjectSchemeName').try(:text)
          @scheme_version = data.xpath('xmlns:SubjectSchemeVersion').try(:text)
          @code = data.xpath('xmlns:SubjectCode').try(:text)
          @heading_text = data.xpath('xmlns:SubjectHeadingText').try(:text)
          @main_subject = data.xpath('xmlns:MainSubject').blank? ? nil : '' 
        end  

        def main_subject?
          @main_subject == ''
        end

    #   def eid
    #      @code
    #    end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end

      end

    end
  end
end
