

module Elibri
  module ONIX
    module Release_3_0

      class Language
        include ROXML
        include Inspector
        xml_name 'Language'

        xml_accessor :role, :from => 'LanguageRole'
        xml_accessor :code, :from => 'LanguageCode'
        
        ATTRIBUTES = [
          :role, :code, :role_name, :language
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]

        def role_name
          Elibri::ONIX::Dict::Release_3_0::LanguageRole.find_by_onix_code(self.role).const_name.downcase
        end
   
        def language
          Elibri::ONIX::Dict::Release_3_0::LanguageCode.find_by_onix_code(self.code).name(:pl).downcase
        end

        def inspect_include_fields
           [:role_name, :language]
        end

        def id
          "#{role}-#{code}"
        end

      end

    end
  end
end
