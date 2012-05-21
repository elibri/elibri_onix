

module Elibri
  module ONIX
    module Release_3_0

      class Language
#       include ROXML
#       include Inspector
#       xml_name 'Language'
#
#       xml_accessor :role, :from => 'LanguageRole'
#       xml_accessor :code, :from => 'LanguageCode'
        
        ATTRIBUTES = [
          :role, :code, :role_name, :language
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :role, :code
        
        def initialize(data)
          @role = data.at_xpath('xmlns:LanguageRole').try(:text)
          @code = data.at_xpath('xmlns:LanguageCode').try(:text)
        end

        def role_name
          Elibri::ONIX::Dict::Release_3_0::LanguageRole.find_by_onix_code(@role).const_name.downcase
        end
   
        def language
          Elibri::ONIX::Dict::Release_3_0::LanguageCode.find_by_onix_code(@code).name(:pl).downcase
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
