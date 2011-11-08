

module Elibri
  module ONIX
    module Release_3_0

      class Language
        include ROXML
        include Inspector
        xml_name 'Language'

        xml_accessor :role, :from => 'LanguageRole'
        xml_accessor :code, :from => 'LanguageCode'

        def role_name
          Elibri::ONIX::Dict::Release_3_0::LanguageRole.find_by_onix_code("01").const_name.downcase
        end
   
        def language
          Elibri::ONIX::Dict::Release_3_0::LanguageCode.find_by_onix_code("pol").name(:en).downcase
        end

        def inspect_include_fields
           [:role_name, :language]
        end

      end

    end
  end
end
