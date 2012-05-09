

module Elibri
  module ONIX
    module Release_3_0

      class Subject
        include ROXML
        include Inspector

        xml_name 'Subject'
        xml_accessor :scheme_identifier, :from => 'SubjectSchemeIdentifier', :as => Fixnum
        xml_accessor :scheme_name, :from => 'SubjectSchemeName'
        xml_accessor :scheme_version, :from => 'SubjectSchemeVersion'
        xml_accessor :code, :from => 'SubjectCode'
        xml_accessor :heading_text, :from => 'SubjectHeadingText'

        xml_accessor :main_subject, :from => 'MainSubject'
        
        ATTRIBUTES = [
          :scheme_identifier, :scheme_name, :scheme_version, :code, :heading_text, :main_subject
        ]
        
        RELATIONS = []

        def main_subject?
          main_subject == ''
        end

      end

    end
  end
end
