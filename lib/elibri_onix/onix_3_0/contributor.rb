
module Elibri
  module ONIX
    module Release_3_0

      class Contributor
        include ExternalId
        include ExternalTimestamp
        
        #from ONIX documentation:
        #Authorship and other forms of contribution are described by repeats of the <Contributor> composite, 
        #within which the recommended form of representation of a person name is the structured data element 
        #group consisting of Person name part 1 to Person name part 8. A single occurrence of the composite may
        #carry both the primary name of a contributor, and one or more alternative names,
        #for example if a contributor is referenced both by their real name and by a pseudonym,
        #or by the name given on the title page and by an authority-controlled name.
        #In addition, more than one representation of the same name may be sent.
        
        ATTRIBUTES = 
        [
          :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :unnamed_persons, :role_name
        ]
        
        RELATIONS =
        [
          :inspect_include_fields
        ]
        
        attr_accessor :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :unnamed_persons, :to_xml
          
        def initialize(data)
          @to_xml = data.to_s
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
          set_eid(data)
          set_datestamp(data)
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
