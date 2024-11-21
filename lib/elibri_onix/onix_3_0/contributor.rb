
module Elibri
  module ONIX
    module Release_3_0
      class Contributor
        include ExternalId
        include ExternalTimestamp
        include Inspector

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

        attr_reader :corporate_name
        attr_reader :corporate_name_inverted

        #reprezentacja danych w xml-u
        attr_reader :to_xml


        def initialize(data)
          @to_xml = data.to_s
          @number = data.at_css('SequenceNumber')&.text&.to_i
          @role = data.at_css('ContributorRole')&.text
          @person_name = data.at_css('PersonName')&.text
          @person_name_inverted = data.at_css('PersonNameInverted')&.text
          @from_language = data.at_css('FromLanguage')&.text
          @titles_before_names = data.at_css('TitlesBeforeNames')&.text
          @names_before_key = data.at_css('NamesBeforeKey')&.text
          @prefix_to_key = data.at_css('PrefixToKey')&.text
          @key_names = data.at_css('KeyNames')&.text
          @names_after_key = data.at_css('NamesAfterKey')&.text
          @biographical_note = data.at_css('BiographicalNote')&.text
          @unnamed_persons = data.at_css('UnnamedPersons')&.text if data.at_css('UnnamedPersons')&.text && data.at_css('UnnamedPersons')&.text.size > 0
          @corporate_name = data.at_css('CorporateName')&.text
          @corporate_name_inverted = data.at_css('CorporateNameInverted')&.text
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
