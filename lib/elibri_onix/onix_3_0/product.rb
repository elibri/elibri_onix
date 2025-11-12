module Elibri
  module ONIX
    module Release_3_0
      #Klasa reprezentująca produkt
      #Niektóre pola mogą pozostać bez wartości - zależy to od formy produktu
      class Product

        include Inspector

        def inspect_include_fields
          [:record_reference, :full_title, :front_cover, :publisher, :isbn13, :ean, :premiere, :contributors, :languages, :description, :product_form_name,
            :technical_protection, :digital_formats]
        end

        #:doc:
        #wysokość w milimetrach
        attr_reader :height

        #szerokość w milimetrach
        attr_reader :width

        #gruboś w milimetrach
        attr_reader :thickness

        #waga w gramach
        attr_reader :weight

        #ean, jeśli jest inny, niż isbn13
        attr_reader :ean

        #isbn13 - bez kresek
        attr_reader :isbn13

        #ilość stron w książce drukowanej
        attr_reader :number_of_pages

        #czas trwania nagrania w audiobooku, w minutach
        attr_reader :duration

        #nazwa wydawnictwa
        attr_reader :publisher_name

        #ID wydawnictwa w systemie elibri
        attr_reader :publisher_id

        #Imprint, jeśli wydawnictwo używa imprintów. Jeżeli wydawnictwo podało imprint, to ta wartość powinna zostać wyświetlona
        #użytkownikowi w sklepie jako nazwa wydawnictwa.
        attr_reader :imprint_name

        #Status produktu - jedna z wartości: announced, :preorder, :published, :out_of_print, :deleted, :indefinitely_postponed, cancelled
        attr_reader :current_state

        #Wiek czytelnika - od
        attr_reader :reading_age_from

        #Wiek czytelnika - do
        attr_reader :reading_age_to

        #Spis treści - jeśli wydawca takowy umieścił, instancja TextContent
        attr_reader :table_of_contents

        #Opis produktu, instancja TextContent
        attr_reader :description

        #lista serii, w postaci [nazwa serii, numer w serii]
        attr_reader :series

        #tytuł ksiażki
        attr_reader :title

        #podtytuł
        attr_reader :subtitle

        #nazwa cyklu (częste przy komiksach, gdy seria jest częścią tytułu, np. Thorgal)
        attr_reader :collection_title

        #numer w cyklu
        attr_reader :collection_part

        #pełen tytuł
        attr_reader :full_title

        #tytuł oryginału
        attr_reader :original_title

        #krótki opis, jeśli wydawca takowy zamieści, instancja TextContent
        attr_reader :short_description

        #data końca licencji, jeśli licencja nie jest bezterminowa, w formacie YYYYMMDD
        attr_reader :licence_limited_to_before_type_cast

        #data końca licencji, jeśli licencja nie jest bezterminowa, instancja Date
        attr_reader :licence_limited_to

        #lista formatów, w jakich jest dostępny ebook (PDF, MOBI, EPUB)
        attr_reader :digital_formats

        #sposób zabezpieczania pliki (DRM, WATERMARK) - pliki dostępne w API transakcyjnym zawsze będą chronione watermarkiem
        attr_reader :technical_protection
        attr_reader :technical_protection_onix_code

        #record reference - wewnętrzny identyfikator rekordu, niezmienny i unikatowy
        attr_reader :record_reference

        #typ okładki, np. 'miękka ze skrzydełkami'
        attr_reader :cover_type

        #sugerowana cena detaliczna brutto produktu
        attr_reader :cover_price

        #stawka VAT
        attr_reader :vat

        #PKWiU
        attr_reader :pkwiu

        #PDWExclusiveness
        attr_reader :pdw_exclusiveness

        #AdditionalInfo
        attr_reader :additional_info

        #kod ONIX typu produktu, np. 'BA' - lista dostępna pod adresem
        #https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/ProductFormCode.yml
        attr_reader :product_form

        #nazwa typu produktu, małe litery, np. 'book' - patrz pełna lista pod adresem
        #https://github.com/elibri/elibri_onix_dict/blob/master/lib/elibri_onix_dict/onix_3_0/serialized/ProductFormCode.yml
        attr_reader :product_form_name

        #lista autorów, tłumaczy i innych, którzy mieli wkład w książkę, lista instancji Contributor
        attr_reader :contributors

        #lista języków, lista intancji Language
        attr_reader :languages

        #informacja o numerze wydania
        attr_reader :edition_statement

        #informacja o type wydanie, kod onix
        attr_reader :edition_type_onix_code

        #liczba ilustracji
        attr_reader :number_of_illustrations

        #reprezentacja xml dla produktu
        attr_reader :to_xml

        #miasto, w którym została wydana ksiażka
        attr_reader :city_of_publication

        #informacje o fragmentach utworów (produkty cyfrowe)
        attr_reader :excerpt_infos

        #informacje o plikach master (produkty cyfrowe)
        attr_reader :file_infos

        #isbn z kreskami
        attr_reader :hyphenated_isbn

        #dodatkowa informacja handlowa
        attr_reader :additional_trade_information

        #ilość elementów (puzzle, gry planszowe)
        attr_reader :number_of_pieces

        #min. ilość graczy - gry planszowe
        attr_reader :players_number_from

        #max. ilość graczy - gry planszowe
        attr_reader :players_number_to

        #min. czas gry - gry planszowe
        attr_reader :playing_time_from

        #max. czas gry - gry planszowe
        attr_reader :playing_time_to

        #cn code
        attr_reader :cn_code

        #kraj produkcji
        attr_reader :country_of_manufacture


        #:nodoc:
        attr_reader :text_contents
        attr_reader :file_size
        attr_reader :reviews
        attr_reader :excerpts
        attr_reader :trade_title
        attr_reader :notification_type
        attr_reader :deletion_text
        attr_reader :product_composition
        attr_reader :measures
        attr_reader :imprint
        attr_reader :publisher
        attr_reader :publishing_status
        attr_reader :title_details
        attr_reader :collections
        attr_reader :extents
        attr_reader :thema_subjects
        attr_reader :publisher_subjects
        attr_reader :audience_ranges
        attr_reader :supply_details
        attr_reader :identifiers
        attr_reader :supporting_resources
        attr_reader :sales_restrictions
        attr_reader :publishing_date
        attr_reader :related_products
        attr_reader :preorder_embargo_date

        #:nodoc:
        attr_accessor :sale_restricted_to_poland, :unlimited_licence, :no_contributor, :preview_exists

        #:doc:
        def initialize(data)
          @to_xml = data.to_s
          #initialize variables that need to be array
          ##descriptive_details
          @text_contents = []
          @supporting_resources = []
          ##collateral_details
          @measures = []
          @title_details = []
          @collections = []
          @contributors = []
          @languages = []
          @extents = []
          @thema_subjects = []
          @publisher_subjects = []
          @audience_ranges = []
          ##publishing_details
          @sales_restrictions = []
          @excerpt_infos = []
          #moving to parsing attributes

          @record_reference = data.at_css('RecordReference')&.text
          @notification_type = data.at_css('NotificationType')&.text
          @deletion_text = data.at_css('DeletionText')&.text

          @identifiers = data.children.find_all { |node| node.name == 'ProductIdentifier' }.map { |ident_data| ProductIdentifier.new(ident_data) }
          begin
            @related_products = data.at_css('RelatedMaterial').css('RelatedProduct').map { |related_data| RelatedProduct.new(related_data) }
          rescue
            @related_products = []
          end
          @supply_details = data.css('SupplyDetail').map { |supply_data| SupplyDetail.new(supply_data) }

          #00 - Supplier role - Unspecified
          price_sd = @supply_details.find { |sd| sd.supplier && ["00", Elibri::ONIX::Dict::Release_3_0::SupplierRole::PUB_TO_RET].include?(sd.supplier.role) }
          if price_sd && price_sd.prices[0] && price_sd.prices[0].type == Elibri::ONIX::Dict::Release_3_0::PriceTypeCode::RRP_WITH_TAX
            @vat = price_sd.prices[0].tax_rate_percent.to_i
            @cover_price = price_sd.prices[0].amount
            @additional_trade_information = price_sd.additional_trade_information
          end

          descriptive_details_setup(data.at_css('DescriptiveDetail')) if data.at_css('DescriptiveDetail')
          collateral_details_setup(data.at_css('CollateralDetail')) if data.at_css('CollateralDetail')

          @preview_exists = !!@supporting_resources.find { |sr| sr.content_type_name == "widget" && sr.link =~ /p.elibri.com.pl/ }

          product_form_features_setup(data.css("ProductFormFeature"))

          publishing_details_setup(data.at_css('PublishingDetail')) if data.at_css('PublishingDetail')
          licence_information_setup(data)
         demo = @supporting_resources.find { |sr| sr.content_type_name == "sample_content" }
          if demo
            @excerpt_infos = demo.data.css("ResourceVersion").map { |node| ExcerptInfo.new(node) }
          end

          @file_infos = data.css("BodyResource").map { |node| FileInfo.new(node) }
          after_parse
        end

        def cover_type
          if @product_form && @product_form =~ /^B/ &&
             Elibri::ONIX::Dict::CoverType.determine_cover_type(@product_form, data.at_css('ProductFormDetail')&.text)
          end
        end

        def licence_information_setup(data)
          daten = data.css('PublishingDate').find { |d| d.at_css("PublishingDateRole") && d.at_css("PublishingDateRole").text == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::OUT_OF_PRINT_DATE }
          if daten
            date = daten.at_css('Date').text
            @licence_limited_to_before_type_cast = date
            @licence_limited_to = _parse_date(date)
            @unlimited_licence = false
          else
            @unlimited_licence = true
          end
        end

        def product_form_features_setup(data)
          data.each do |feature|
            ftype = feature.at_css("ProductFormFeatureType").inner_text
            v1, v2 = feature.at_css("ProductFormFeatureValue, ProductFormFeatureDescription").inner_text.split("-").map(&:to_i)

            if ftype == Elibri::ONIX::Dict::Release_3_0::ProductFormFeatureType::NUMBER_OF_GAME_PIECES
              @number_of_pieces = v1
            elsif ftype == Elibri::ONIX::Dict::Release_3_0::ProductFormFeatureType::GAME_PLAYERS
              @players_number_from = v1
              @players_number_to = v2
            elsif ftype == Elibri::ONIX::Dict::Release_3_0::ProductFormFeatureType::GAME_PLAY_TIME
              @playing_time_from = v1
              @playing_time_to = v2
            end
          end
        end

        def descriptive_details_setup(data)
          @country_of_manufacture = data.at_css("CountryOfManufacture")&.text

          @product_composition = data.at_css('ProductComposition')&.text
          @product_form = data.at_css('ProductForm')&.text
          if @product_form
            if Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(@product_form)
              @product_form_name = Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(@product_form).name(:en).downcase
            end

            simplified_product_form = @product_form =~ /^B/ ? "BA" : @product_form
            if Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(simplified_product_form)&.digital?
              @digital_formats = []
              data.css("ProductFormDetail").each do |format|
                format_name = Elibri::ONIX::Dict::Release_3_0::ProductFormDetail::find_by_onix_code(format.text)&.name
                @digital_formats << format_name.upcase.gsub("MOBIPOCKET", "MOBI") if format_name
              end
            end

          end
          data.css('ProductClassification').each do |cl|
            cl_type = cl.at_css('ProductClassificationType').text
            cl_value = cl.at_css('ProductClassificationCode').text
            if cl_type == Elibri::ONIX::Dict::Release_3_0::ProductClassificationType::PKWIU
              @pkwiu = cl_value
            elsif cl_type == Elibri::ONIX::Dict::Release_3_0::ProductClassificationType::CN
              @cn_code = cl_value
            end
          end
          @measures =  data.css('Measure').map { |measure_data| Measure.new(measure_data) }
          @title_details = data.children.find_all { |node| node.name == 'TitleDetail' }.map { |title_data| TitleDetail.new(title_data) }
          @collections = data.css('Collection').map { |collection_data| Collection.new(collection_data) }
          @contributors = data.css('Contributor').map { |contributor_data| Contributor.new(contributor_data) }
          @no_contributor = !!data.at_css('NoContributor')
          @languages = data.css('Language').map { |language_data| Language.new(language_data) }
          @extents = data.css('Extent').map { |extent_data| Extent.new(extent_data) }

          @publisher_subjects = data.css('Subject').find_all { |sd|
             %w{24}.include?(sd.at_css('SubjectSchemeIdentifier')&.text) }.map { |sd| PublisherSubject.new(sd) }
          @thema_subjects = data.css('Subject').find_all { |sd|
             %w{93 94 95 96 97 98 99}.include?(sd.at_css('SubjectSchemeIdentifier')&.text) }.map { |sd| ThemaSubject.new(sd) }
          @audience_ranges = data.css('AudienceRange').map { |audience_data| AudienceRange.new(audience_data) }

          #zabezpiecznie pliku
          if protection = data.at_css("EpubTechnicalProtection")&.text
            @technical_protection =  Elibri::ONIX::Dict::Release_3_0::EpubTechnicalProtection::find_by_onix_code(protection)&.name
            @technical_protection_onix_code = protection
          end

          @edition_statement = data.at_css('EditionStatement')&.text
          if Elibri::ONIX::Dict::Release_3_0::EditionType.find_by_onix_code(data.at_css('EditionType')&.text)
            @edition_type_onix_code = data.at_css('EditionType')&.text
          end

          @number_of_illustrations = data.at_css('NumberOfIllustrations')&.text&.to_i
        end

        def collateral_details_setup(data)
          @text_contents = data.css('TextContent').map { |text_detail| TextContent.new(text_detail) }
          @supporting_resources = data.css('SupportingResource').map { |supporting_data| SupportingResource.new(supporting_data) }
        end

        def publishing_details_setup(data)
          @imprint = Imprint.new(data.at_css('Imprint')) if data.at_css('Imprint')
          @publisher = Publisher.new(data.at_css('Publisher')) if data.at_css('Publisher')
          @publishing_status = data.at_css('PublishingStatus')&.text
          @city_of_publication = data.at_css("CityOfPublication")&.text
          publication_dates = data.css('PublishingDate').map do |node|
            PublishingDate.new(node)
          end
          @publishing_date = publication_dates.find { |date| date.role == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::PUBLICATION_DATE }
          preorder_embargo_date_as_object = publication_dates.find { |date| date.role == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::PREORDER_EMBARGO_DATE }
          @preorder_embargo_date = Date.new(*preorder_embargo_date_as_object.parsed) if preorder_embargo_date_as_object

          @sales_restrictions = data.css('SalesRestriction').map { |restriction_data| SalesRestriction.new(restriction_data) }
          #ograniczenia terytorialne
          if data.at_css("CountriesIncluded")&.text == "PL"
            @sale_restricted_to_poland = true
          else
            @sale_restricted_to_poland = false
          end
        end

        def exclusive_distributor_onix_code
          if @sales_restrictions.size > 0
            @sales_restrictions[0].outlet_code
          end
        end

        def sales_restrictions?
          @sales_restrictions.size > 0
        end

        #flaga, czy sprzedaż książki jest ograniczona do Polski
        def sale_restricted_to_poland?
          @sale_restricted_to_poland
        end

        #flaga informująca, czy licencja jest bezterminowa
        def unlimited_licence?
          @unlimited_licence
        end

        #flaga - true, jeśli produkt nie ma żadnego autora
        def no_contributor?
          @no_contributor
        end

        #flaga, czy książka to praca zbiorowa?
        def unnamed_persons?
          @contributors.size == 1 && contributors[0].unnamed_persons
        end

        #flaga, czy istnieje podgląd produktu
         def preview_exists?
           @preview_exists
         end

        def authors
          unnamed_persons? ? ["praca zbiorowa"] : @contributors.find_all { |c| c.role_name == "author" }.map(&:person_name)
        end

        [:ghostwriter, :scenarist, :originator, :illustrator, :photographer, :author_of_preface, :drawer, :cover_designer,
         :inked_or_colored_by, :editor, :revisor, :translator, :editor_in_chief, :read_by].each do |role|
          define_method "#{role}s" do
            @contributors.find_all { |c| c.role_name == role.to_s }.map(&:person_name)
          end
        end

        [:announced, :preorder, :published, :out_of_print].each do |state|
          define_method "#{state}?" do
            current_state == state
          end
        end

        #okładka ksiązki, instance SupportingResource
        def front_cover
          @supporting_resources.find { |resource| resource.content_type_name == "front_cover" }
        end

        #lista nazwa serii, do których należy produkt
        def series_names
          @series.map { |series| series[0] }
        end

        #data premiery, jako instancja Date (tylko wtedy, gdy dokładna data jest znana)
        def premiere
          Date.new(*parsed_publishing_date) if parsed_publishing_date.size == 3
        rescue ArgumentError
          nil
        end

        def related_products_record_references
          related_products.map(&:record_reference)
        end

        #:nodoc:
        def proprietary_identifiers
          @identifiers.find_all { |i| i.identifier_type == "proprietary" }.inject({}) { |res, ident| res[ident.type_name] = ident.value; res }
        end

        #data premiery w postaci listy [rok, miesiąc, dzień], [rok, miesiąc], [rok], lub pustej listy - jeśli data premiery nie jest znana
        #(data premiery może nie być znana w przypadku backlisty)
        def parsed_publishing_date
          if publishing_date
            publishing_date.parsed
          else
            []
          end
        end


    private

        def find_title(code)
          @title_details.find {|title_detail| title_detail.type == code}
        end

        def after_parse
          %w{height width thickness weight}.each do |mn|
            instance_variable_set("@#{mn}", measures.find { |m| m.type_name == mn }&.measurement)
          end

          @ean = @identifiers.find { |identifier| identifier.identifier_type == "ean" }&.value

          @number_of_pages = @extents.find {|extent| extent.type_name == "page_count" }&.value
          @duration = @extents.find {|extent| extent.type_name == "duration" }&.value
          @file_size = @extents.find {|extent| extent.type_name == "file_size" }&.value
          @publisher_name = @publisher.name if publisher
          @publisher_id = @publisher.eid if publisher
          @imprint_name = @imprint.name if imprint
          @isbn13 = @identifiers.find { |identifier| identifier.identifier_type == "isbn13" }&.value
          @hyphenated_isbn ||= @isbn13
          @reading_age_from = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "03")}&.value&.to_i
          @reading_age_to = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "04")}&.value&.to_i
          @table_of_contents = @text_contents.find { |t| t.type_name == "table_of_contents" }
          @description = @text_contents.find { |t| t.type_name == "main_description" }
          @short_description = @text_contents.find { |t| t.type_name == "short_description" }
          @reviews = @text_contents.find_all { |t| t.type_name == "review" }
          @excerpts = @text_contents.find_all { |t| t.type_name == "excerpt" }
          @series = @collections.map { |c| [c.title_detail.elements[0].title,  c.title_detail.elements[0].part_number] }
          distinctive_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE)
          if distinctive_title
            @title = distinctive_title.product_level&.title
            @subtitle = distinctive_title.product_level&.subtitle
            @collection_title = distinctive_title.collection_level&.title
            @collection_part = distinctive_title.collection_level&.part_number
          end
          @full_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE)&.full_title
          @original_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::ORIGINAL_TITLE)&.full_title
          @trade_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTRIBUTORS_TITLE)&.full_title

          compute_state!
        end



        def compute_state!
          if @notification_type || @publishing_status
            if @notification_type == "01"
              @current_state = :announced
            elsif @notification_type == "02"
              if @publishing_status == "01"
                @current_state = :cancelled
              elsif @publishing_status == "02"
                @current_state = :preorder
              elsif @publishing_status == "03"
                @current_state = :indefinitely_postponed
              end
            elsif @notification_type == "05"
              @current_state = :deleted
            else
              if @publishing_status == "04"
                @current_state = :published
              elsif @publishing_status == "07"
                @current_state = :out_of_print
              elsif @notification_type == "03"
                @current_state = :published
              else
                raise "cannot determine the state of the product #{@record_reference}"
              end
            end
          end
        end

        def _parse_date(string)
          Date.new(string[0...4].to_i, string[4...6].to_i, string[6...8].to_i)
        rescue ArgumentError
          raise "Invalid date '#{string}' when parsing date for #{@record_reference}"
        end
      end

    end
  end
end
