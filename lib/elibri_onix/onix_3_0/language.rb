

module Elibri
  module ONIX
    module Release_3_0

      class Language

        #from ONIX documentation:
        #An optional and repeatable group of data elements which together represent a language, and specify its role and,
        #where required, whether it is a country variant.

        include Inspector

        #:nodoc:       
        ATTRIBUTES = [
          :role, :code, :role_name, :language
        ]

        #:nodoc:
        RELATIONS = [
          :inspect_include_fields
        ]

        #:doc:       
        #kod onix roli, np. '01' 
        #pełna lista ról: https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/LanguageRole.yml
        attr_reader :role

        #kod języka, np. 'pol'
        #pełna lista kodów: https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/LanguageCode.yml
        attr_reader :code

        #reprezentacja w xml
        attr_reader :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_css('LanguageRole').try(:text)
          @code = data.at_css('LanguageCode').try(:text)
        end

        #określenie roli jako string, np. language_of_text
        def role_name
          Elibri::ONIX::Dict::Release_3_0::LanguageRole.find_by_onix_code(@role).const_name.downcase
        end

        #język, np. 'polski'
        def language
          Elibri::ONIX::Dict::Release_3_0::LanguageCode.find_by_onix_code(@code).name(:pl).downcase rescue nil
        rescue 

        end

        def inspect_include_fields
           [:role_name, :language]
        end
      end
    end
  end
end
