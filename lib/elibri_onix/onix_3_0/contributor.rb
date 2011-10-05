
module Elibri
  module ONIX
    module Release_3_0

      class Contributor
        include ROXML

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

      end

    end
  end
end
