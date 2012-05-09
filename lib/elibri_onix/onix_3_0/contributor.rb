
module Elibri
  module ONIX
    module Release_3_0

      class Contributor
        include ROXML
        include Inspector
        include ExternalId
        include ExternalTimestamp
        
        ATTRIBUTES = 
        [
          :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :unnamed_persons, :role_name
        ]
        
        RELATIONS =
        [
          :inspect_include_fields
        ]

        xml_name 'Contributor'

        xml_accessor :number, :from => 'SequenceNumber', :as => Fixnum
        xml_accessor :role, :from => 'ContributorRole'
        xml_accessor :person_name, :from => 'PersonName'
        xml_accessor :from_language, :from => 'FromLanguage'
        xml_accessor :titles_before_names, :from => 'TitlesBeforeNames'
        xml_accessor :names_before_key, :from => 'NamesBeforeKey'
        xml_accessor :prefix_to_key, :from => 'PrefixToKey'
        xml_accessor :key_names, :from => 'KeyNames'
        xml_accessor :names_after_key, :from => 'NamesAfterKey'
        xml_accessor :biographical_note, :from => 'BiographicalNote'

        xml_accessor :unnamed_persons, :from => 'UnnamedPersons'

        def role_name
          Elibri::ONIX::Dict::Release_3_0::ContributorRole.find_by_onix_code(self.role).const_name.downcase
        end

        def inspect_include_fields
          [:role_name]
        end
      end

    end
  end
end
