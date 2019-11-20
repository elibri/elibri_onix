
module Elibri
  module ONIX
    module Release_3_0
      #Klasa reprezentująca produkt
      #Niektóre pola mogą pozostać bez wartości - zależy to od formy produktu
      class Product

        include Inspector

        #:nodoc:
        ATTRIBUTES =
        [
          :height, :width, :thickness, :weight, :ean, :isbn13, :number_of_pages, :duration, 
          :file_size, :publisher_name, :publisher_id, :imprint_name, :current_state, :reading_age_from, :reading_age_to, 
          :table_of_contents, :description, :reviews, :excerpts, :series, :title, :subtitle, :collection_title,
          :collection_part, :full_title, :original_title, :trade_title, :parsed_publishing_date, :record_reference,
          :deletion_text, :cover_type, :cover_price, :vat, :pkwiu, :additional_info, :product_composition, 
          :publisher, :product_form, :no_contributor, :edition_statement, :edition_type_onix_code, :number_of_illustrations, :publishing_status,
          :publishing_date, :premiere, :front_cover, :series_names, :city_of_publication,
          :preview_exists, :short_description, :sale_restricted_to_poland,
          :technical_protection_onix_code, :unlimited_licence, :hyphenated_isbn, :preorder_embargo_date, :additional_trade_information
        ]

        #:nodoc:
        RELATIONS =
        [
          :contributors, #IMPORTANT
          :related_products, :languages, :measures, :supply_details, :measures, :title_details,
          :collections, :extents, :thema_subjects, :audience_ranges,
          :text_contents, #IMPORTANT
          :supporting_resources, #for example: cover
          :sales_restrictions, :authors,
          :ghostwriters, :scenarists, :originators, :illustrators, :photographers, :author_of_prefaces, :drawers,
          :cover_designers, :inked_or_colored_bys, :editors, :revisors, :translators, :editor_in_chiefs, :read_bys
        ]

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

        #Status produktu - jedna z wartości: announced, :preorder, :published, :out_of_print, :deleted
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
          @audience_ranges = []
          ##publishing_details
          @sales_restrictions = []
          @excerpt_infos = []
          @cover_type = nil
          #moving to parsing attributes

          @record_reference = data.at_css('RecordReference').try(:text)
          @notification_type = data.at_css('NotificationType').try(:text)
          @deletion_text = data.at_css('DeletionText').try(:text)

          if data.namespaces.values.any? { |uri| uri =~ /elibri/ }
            @cover_type = data.at_xpath('elibri:CoverType').try(:text) 
            @pkwiu = data.at_xpath('elibri:PKWiU').try(:text)
            @hyphenated_isbn = data.at_xpath('elibri:HyphenatedISBN').try(:text)
            @pdw_exclusiveness = data.at_xpath('elibri:PDWExclusiveness').try(:text)
            @additional_info = data.at_xpath('elibri:AdditionalInfo').try(:text)
          end

          @identifiers = data.children.find_all { |node| node.name == 'ProductIdentifier' }.map { |ident_data| ProductIdentifier.new(ident_data) }
          begin
            @related_products = data.at_css('RelatedMaterial').css('RelatedProduct').map { |related_data| RelatedProduct.new(related_data) }
          rescue
            @related_products = []
          end
          begin
            @supply_details = data.at_css('ProductSupply').css('SupplyDetail').map { |supply_data| SupplyDetail.new(supply_data) }
          rescue
            @supply_details = []
          end

          if data.namespaces.values.any? { |uri| uri =~ /elibri/ } && (data.at_xpath('elibri:Vat') || data.at_xpath('elibri:CoverPrice'))
            @cover_price = BigDecimal(data.at_xpath('elibri:CoverPrice').try(:text)) if data.at_xpath('elibri:CoverPrice')
            @vat = data.at_xpath('elibri:Vat').try(:text).try(:to_i)
          else
            price_sd = @supply_details.find { |sd| sd.supplier.role == Elibri::ONIX::Dict::Release_3_0::SupplierRole::PUB_TO_RET }
            if price_sd && price_sd.price && price_sd.price && price_sd.price.type == Elibri::ONIX::Dict::Release_3_0::PriceTypeCode::RRP_WITH_TAX 
              @vat = price_sd.price.tax_rate_percent.to_i
              @cover_price = price_sd.price.amount
              @additional_trade_information = price_sd.additional_trade_information
            end
          end

          descriptive_details_setup(data.at_css('DescriptiveDetail')) if data.at_css('DescriptiveDetail')
          collateral_details_setup(data.at_css('CollateralDetail')) if data.at_css('CollateralDetail')

          if data.namespaces.values.any? { |uri| uri =~ /elibri/ } && data.at_xpath('elibri:preview_exists')
            @preview_exists = (data.at_xpath('elibri:preview_exists').text == "true")
          else
            @preview_exists = @supporting_resources.find { |sr| sr.content_type_name == "widget" && sr.link =~ /p.elibri.com.pl/ }.present?
          end


          publishing_details_setup(data.at_css('PublishingDetail')) if data.at_css('PublishingDetail')
          licence_information_setup(data)
          begin
            @excerpt_infos = data.at_xpath("elibri:excerpts").xpath("elibri:excerpt").map { |node| ExcerptInfo.new(node) }
          rescue
           demo = @supporting_resources.find { |sr| sr.content_type_name == "sample_content" }
            if demo
              @excerpt_infos = demo.data.css("ResourceVersion").map { |node| ExcerptInfo.new(node) }
            end

          end
          begin
            @file_infos = data.at_xpath("elibri:masters").xpath("elibri:master").map { |node| FileInfo.new(node) }
          rescue
            @file_infos = []
          end
          after_parse
        end

        def self.determine_cover_type(product_form, product_form_detail)
          if product_form == "BG"
            "skórzana"
          elsif product_form == "BF"
            "gąbka"
          elsif product_form == "BC"
             if product_form_detail == "B504"
              "miękka ze skrzydełkami"
            elsif product_form_detail == "B412"
              "zintegrowana"
            else
              "miękka"
            end
          elsif product_form == "BB"
            if product_form_detail == "B501"
              "twarda z obwolutą"
            elsif product_form_detail == "B415"
              "twarda lakierowana"
            elsif product_form_detail == "B413"
              "plastikowa"
            else
              "twarda"
            end
          end
        end

        def licence_information_setup(data)
          if data.namespaces.values.any? { |uri| uri =~ /elibri/ } && (data.at_xpath("elibri:SaleNotRestricted") || data.at_xpath("elibri:SaleRestrictedTo"))
            if data.at_xpath("elibri:SaleNotRestricted")
              @unlimited_licence = true
            elsif date = data.at_xpath("elibri:SaleRestrictedTo").try(:text)
              @unlimited_licence = false
              @licence_limited_to_before_type_cast = date
              @licence_limited_to = Date.new(date[0...4].to_i, date[4...6].to_i, date[6...8].to_i)
            end
          else
            daten = data.css('PublishingDate').find { |d| d.at_css("PublishingDateRole").text == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::OUT_OF_PRINT_DATE }
            if daten
          
              date = daten.at_css('Date').text
              @licence_limited_to_before_type_cast = date
              @licence_limited_to = Date.new(date[0...4].to_i, date[4...6].to_i, date[6...8].to_i)
              @unlimited_licence = false
            else
              @unlimited_licence = true
            end

          end
        end

        def descriptive_details_setup(data)
          @product_composition = data.at_css('ProductComposition').try(:text)
          @product_form = data.at_css('ProductForm').text
          if @product_form.starts_with?("B") && !@cover_type
            @cover_type = self.class.determine_cover_type(@product_form, data.at_css('ProductFormDetail').try(:text))
          end
          if Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(@product_form)
            @product_form_name = Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(@product_form).name(:en).downcase
          end
          if classification = data.css('ProductClassification').find { |cl| 
             cl.at_css('ProductClassificationType').text == Elibri::ONIX::Dict::Release_3_0::ProductClassificationType::PKWIU }
            @pkwiu  = classification.at_css('ProductClassificationCode').text
          end
          @measures =  data.css('Measure').map { |measure_data| Measure.new(measure_data) }
          @title_details = data.children.find_all { |node| node.name == 'TitleDetail' }.map { |title_data| TitleDetail.new(title_data) }
          @collections = data.css('Collection').map { |collection_data| Collection.new(collection_data) }
          @contributors = data.css('Contributor').map { |contributor_data| Contributor.new(contributor_data) }
          @no_contributor = !!data.at_css('NoContributor')
          @languages = data.css('Language').map { |language_data| Language.new(language_data) }
          @extents = data.css('Extent').map { |extent_data| Extent.new(extent_data) }
          @thema_subjects = data.css('Subject').find_all { |sd| 
             %w{93 94 95 96 97 98 99}.include?(sd.at_css('SubjectSchemeIdentifier').try(:text)) }.map { |sd| ThemaSubject.new(sd) }
          @audience_ranges = data.css('AudienceRange').map { |audience_data| AudienceRange.new(audience_data) }

          simplified_product_form = @product_form.starts_with?("B") ? "BA" : @product_form
          if Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(simplified_product_form).digital?
            @digital_formats = []
            data.css("ProductFormDetail").each do |format|
              @digital_formats << Elibri::ONIX::Dict::Release_3_0::ProductFormDetail::find_by_onix_code(format.text).name.upcase.gsub("MOBIPOCKET", "MOBI")
            end
          end

          #zabezpiecznie pliku
          if protection = data.at_css("EpubTechnicalProtection").try(:text)
            @technical_protection =  Elibri::ONIX::Dict::Release_3_0::EpubTechnicalProtection::find_by_onix_code(protection).name
            @technical_protection_onix_code = protection
          end

          @edition_statement = data.at_css('EditionStatement').try(:text)
          if Elibri::ONIX::Dict::Release_3_0::EditionType.find_by_onix_code(data.at_css('EditionType').try(:text))
            @edition_type_onix_code = data.at_css('EditionType').try(:text)
          end

          @number_of_illustrations = data.at_css('NumberOfIllustrations').try(:text).try(:to_i)
        end

        def collateral_details_setup(data)
          @text_contents = data.css('TextContent').map { |text_detail| TextContent.new(text_detail) }
          @supporting_resources = data.css('SupportingResource').map { |supporting_data| SupportingResource.new(supporting_data) }
        end

        def publishing_details_setup(data)
          @imprint = Imprint.new(data.at_css('Imprint')) if data.at_css('Imprint')
          @publisher = Publisher.new(data.at_css('Publisher')) if data.at_css('Publisher')
          @publishing_status = data.at_css('PublishingStatus').try(:text)
          @city_of_publication = data.at_css("CityOfPublication").try(:text)
          publication_dates = data.css('PublishingDate').map do |node|
            PublishingDate.new(node)
          end
          @publishing_date = publication_dates.find { |date| date.role == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::PUBLICATION_DATE }
          preorder_embargo_date_as_object = publication_dates.find { |date| date.role == Elibri::ONIX::Dict::Release_3_0::PublishingDateRole::PREORDER_EMBARGO_DATE }
          @preorder_embargo_date = Date.new(*preorder_embargo_date_as_object.parsed) if preorder_embargo_date_as_object

          @sales_restrictions = data.css('SalesRestriction').map { |restriction_data| SalesRestriction.new(restriction_data) }      
          #ograniczenia terytorialne
          if data.at_css("CountriesIncluded").try(:text) == "PL"
            @sale_restricted_to_poland = true
          else
            @sale_restricted_to_poland = false
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
          @contributors.size == 1 && contributors[0].unnamed_persons.present?
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
          if sales_restrictions?
            date = sales_restrictions[0].end_date
            [date.year, date.month, date.day]
          elsif publishing_date
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
            instance_variable_set("@#{mn}", measures.find { |m| m.type_name == mn }.try(:measurement))
          end

          @ean = @identifiers.find { |identifier| identifier.identifier_type == "ean" }.try(:value)

          @number_of_pages = @extents.find {|extent| extent.type_name == "page_count" }.try(:value)
          @duration = @extents.find {|extent| extent.type_name == "duration" }.try(:value)
          @file_size = @extents.find {|extent| extent.type_name == "file_size" }.try(:value)
          @publisher_name = @publisher.name if publisher
          @publisher_id = @publisher.eid if publisher
          @imprint_name = @imprint.name if imprint
          @isbn13 = @identifiers.find { |identifier| identifier.identifier_type == "isbn13" }.try(:value)
          @hyphenated_isbn ||= @isbn13
          @reading_age_from = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "03")}.try(:value).try(:to_i)
          @reading_age_to = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "04")}.try(:value).try(:to_i)
          @table_of_contents = @text_contents.find { |t| t.type_name == "table_of_contents" }
          @description = @text_contents.find { |t| t.type_name == "main_description" }
          @short_description = @text_contents.find { |t| t.type_name == "short_description" }
          @reviews = @text_contents.find_all { |t| t.type_name == "review" }
          @excerpts = @text_contents.find_all { |t| t.type_name == "excerpt" }
          @series = @collections.map { |c| [c.title_detail.elements[0].title,  c.title_detail.elements[0].part_number] }
          distinctive_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE)
          if distinctive_title
            @title = distinctive_title.product_level.try(:title)
            @subtitle = distinctive_title.product_level.try(:subtitle)
            @collection_title = distinctive_title.collection_level.try(:title)
            @collection_part = distinctive_title.collection_level.try(:part_number)
          end
          @full_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).try(:full_title)
          @original_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::ORIGINAL_TITLE).try(:full_title)
          @trade_title = find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTRIBUTORS_TITLE).try(:full_title)

          compute_state!
        end



        def compute_state!
          if @notification_type == "01"
            @current_state = :announced
          elsif @notification_type == "02"
            @current_state = :preorder
          elsif @notification_type == "05"
            @current_state = :deleted
          else
            if @publishing_status == "04"
              @current_state = :published
            elsif @publishing_status == "07"
              @current_state = :out_of_print
            else
              raise "cannot determine the state of the product #{@record_reference}"
            end
          end
        end
      end

    end
  end
end
