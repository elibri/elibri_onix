
module Elibri
  module ONIX
    module Release_3_0

      class Contributor
        include ExternalId
        include ExternalTimestamp
        include Inspector

        #from ONIX documentation:
        #Authorship and other forms of contribution are described by repeats of the <Contributor> composite, 
        #within which the recommended form of representation of a person name is the structured data element 
        #group consisting of Person name part 1 to Person name part 8. A single occurrence of the composite may
        #carry both the primary name of a contributor, and one or more alternative names,
        #for example if a contributor is referenced both by their real name and by a pseudonym,
        #or by the name given on the title page and by an authority-controlled name.
        #In addition, more than one representation of the same name may be sent.

        #:nodoc:
        ATTRIBUTES = 
        [
          :number, :role, :person_name, :from_language, :titles_before_names, :names_before_key, :prefix_to_key,
          :key_names, :names_after_key, :biographical_note, :unnamed_persons, :role_name
        ]

        #:nodoc:
        RELATIONS =
        [
          :inspect_include_fields
        ]

        #:nodoc:
        attr_reader :number

        #:doc:
        #kod ONIX dla roli - np. 'A01' - autor, pełna lista pod adresem 
        #https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/ProductFormCode.yml
        attr_reader :role

        #pełne imię i nazwisko - to pole jest zawsze uzupełnione
        attr_reader :person_name

        #jednak czasami, nie ma :person_name, jest za to :person_name_inverted - e-isbn
        attr_reader :person_name_inverted

        #w przypadku tłumacza kod języka oryginału, lista języków dostępna pod adresem
        #https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/LanguageCode.yml
        attr_reader :from_language

        #tytuł naukowy, np. prof.
        attr_reader :titles_before_names

        #imię lub imiona
        attr_reader :names_before_key

        #prefix przed nazwiskiem, np. von, van
        attr_reader :prefix_to_key

        #nazwisko lub nazwiska
        attr_reader :key_names

        #dodatkowe oznaczenia, np. OHP (zakon)
        attr_reader :names_after_key

        #biografia
        attr_reader :biographical_note

        #:nodoc:
        attr_reader :unnamed_persons

        #reprezentacja danych w xml-u
        attr_reader :to_xml


        def initialize(data)
          @to_xml = data.to_s
          @number = data.at_css('SequenceNumber').try(:text).try(:to_i)
          @role = data.at_css('ContributorRole').try(:text)
          @person_name = data.at_css('PersonName').try(:text)
          @person_name_inverted = data.at_css('PersonNameInverted').try(:text)
          @from_language = data.at_css('FromLanguage').try(:text)
          @titles_before_names = data.at_css('TitlesBeforeNames').try(:text)
          @names_before_key = data.at_css('NamesBeforeKey').try(:text)
          @prefix_to_key = data.at_css('PrefixToKey').try(:text)
          @key_names = data.at_css('KeyNames').try(:text)
          @names_after_key = data.at_css('NamesAfterKey').try(:text)
          @biographical_note = data.at_css('BiographicalNote').try(:text)
          @unnamed_persons = data.at_css('UnnamedPersons').try(:text)
          set_eid(data)
          set_datestamp(data)
        end

        def role_name
          Elibri::ONIX::Dict::Release_3_0::ContributorRole.find_by_onix_code(@role).const_name.downcase rescue nil
        end

        def inspect_include_fields
          [:role_name, :person_name]
        end

      end

    end
  end
end
