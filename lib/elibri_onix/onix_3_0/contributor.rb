
module Elibri
  module ONIX
    module Release_3_0

      class Contributor
#        include ROXML
#        include Inspector
#        include ExternalId
#        include ExternalTimestamp
        
        ATTRIBUTES = 
        [
          :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :unnamed_persons, :role_name
        ]
        
        RELATIONS =
        [
          :inspect_include_fields
        ]

#        xml_name 'Contributor'

#        xml_accessor :number, :from => 'SequenceNumber', :as => Fixnum
#        xml_accessor :role, :from => 'ContributorRole'
#        xml_accessor :person_name, :from => 'PersonName'
#        xml_accessor :from_language, :from => 'FromLanguage'
#        xml_accessor :titles_before_names, :from => 'TitlesBeforeNames'
#        xml_accessor :names_before_key, :from => 'NamesBeforeKey'
#        xml_accessor :prefix_to_key, :from => 'PrefixToKey'
#        xml_accessor :key_names, :from => 'KeyNames'
#        xml_accessor :names_after_key, :from => 'NamesAfterKey'
#        xml_accessor :biographical_note, :from => 'BiographicalNote'
#
#        xml_accessor :unnamed_persons, :from => 'UnnamedPersons'
        
        attr_accessor :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :biographical_note
          
        def initialize(data)
          @number = data.at_xpath('xmlns:SequenceNumber').try(:text).try(:to_i)
          @role = data.at_xpath('xmlns:ContributorRole').try(:text)
          @person_name = data.at_xpath('xmlns:PersonName').try(:text)
          @from_language = data.at_xpath('xmlns:FromLanguage').try(:text)
          @titles_before_names = data.at_xpath('xmlns:TitlesBeforeNames').try(:text)
          @names_before_key = data.at_xpath('xmlns:NamesBeforeKey').try(:text)
          @prefix_to_key = data.at_xpath('xmlns:PrefixToKey').try(:text)
          @key_names = data.at_xpath('xmlns:KeyNames').try(:text)
          @names_after_key = data.at_xpath('xmlns:NamesAfterKey').try(:text)
          @biographical_note = data.at_xpath('xmlns:BiographicalNote').try(:text)
          @unnamed_persons = data.at_xpath('xmlns:UnnamedPersons').try(:text)
        end

        def role_name
          Elibri::ONIX::Dict::Release_3_0::ContributorRole.find_by_onix_code(@role).const_name.downcase
        end

        def inspect_include_fields
          [:role_name]
        end
         
      end

    end
  end
end
