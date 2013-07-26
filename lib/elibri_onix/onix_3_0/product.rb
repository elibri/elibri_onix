
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
          :elibri_dialect, :height, :width, :thickness, :weight, :ean, :isbn13, :number_of_pages, :duration, 
          :file_size, :publisher_name, :publisher_id, :imprint_name, :current_state, :reading_age_from, :reading_age_to, 
          :table_of_contents, :description, :reviews, :excerpts, :series, :title, :subtitle, :collection_title,
          :collection_part, :full_title, :original_title, :trade_title, :parsed_publishing_date, :record_reference,
          :deletion_text, :cover_type, :cover_price, :vat, :pkwiu, :product_composition, 
          :publisher, :product_form, :no_contributor, :edition_statement, :number_of_illustrations, :publishing_status,
          :publishing_date, :premiere, :front_cover, :series_names, :city_of_publication,
          :elibri_product_category1_id, :elibri_product_category2_id, :preview_exists, :short_description, :sale_restricted_to_poland,
          :technical_protection_onix_code, :unlimited_licence
        ]
        
        #:nodoc:
        RELATIONS =
        [
          :contributors, #IMPORTANT
          :related_products, :languages, :measures, :supply_details, :measures, :title_details,
          :collections, :extents, :subjects, :audience_ranges,
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

        #id kategorii elibri (1)
        attr_reader :elibri_product_category1_id

        #id kategorii elibri (2)
        attr_reader :elibri_product_category2_id

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

        #liczba ilustracji
        attr_reader :number_of_illustrations

        #reprezentacja xml dla produktu
        attr_reader :to_xml

        #miasto, w którym została wydana ksiażka
        attr_reader :city_of_publication


        #:nodoc:
        attr_reader :text_contents
        attr_reader :file_size
        attr_reader :elibri_dialect
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
        attr_reader :subjects
        attr_reader :audience_ranges
        attr_reader :supply_details
        attr_reader :identifiers
        attr_reader :no_contributor
        attr_reader :supporting_resources
        attr_reader :sales_restrictions
        attr_reader :publishing_date
        attr_reader :related_products

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
          @subjects = []
          @audience_ranges = []
          ##publishing_details
          @sales_restrictions = []
          
          #moving to parsing attributes
          
          @elibri_dialect = data.at_xpath('//elibri:Dialect').try(:text)
          @record_reference = data.at_xpath('xmlns:RecordReference').try(:text)
          @notification_type = data.at_xpath('xmlns:NotificationType').try(:text)
          @deletion_text = data.at_xpath('xmlns:DeletionText').try(:text)
          @cover_type = data.at_xpath('elibri:CoverType').try(:text)
          @cover_price = BigDecimal.new(data.at_xpath('elibri:CoverPrice').try(:text)) if data.at_xpath('elibri:CoverPrice')
          @vat = data.at_xpath('elibri:Vat').try(:text).try(:to_i)
          @pkwiu = data.at_xpath('elibri:PKWiU').try(:text)
          @preview_exists = (data.at_xpath('elibri:preview_exists').try(:text) == "true")
          @identifiers = data.xpath('xmlns:ProductIdentifier').map { |ident_data| ProductIdentifier.new(ident_data) }
          begin
            @related_products = data.at_xpath('xmlns:RelatedMaterial').xpath('xmlns:RelatedProduct').map { |related_data| RelatedProduct.new(related_data) }
          rescue
            @related_products = []
          end
          begin
            @supply_details = data.at_xpath('xmlns:ProductSupply').xpath('xmlns:SupplyDetail').map { |supply_data| SupplyDetail.new(supply_data) }
          rescue
            @supply_details = []
          end
          descriptive_details_setup(data.at_xpath('xmlns:DescriptiveDetail')) if data.at_xpath('xmlns:DescriptiveDetail')
          collateral_details_setup(data.at_xpath('xmlns:CollateralDetail')) if data.at_xpath('xmlns:CollateralDetail')
          publishing_details_setup(data.at_xpath('xmlns:PublishingDetail')) if data.at_xpath('xmlns:PublishingDetail')
          licence_information_setup(data)
          after_parse
        end
 
        def licence_information_setup(data)
          if data.at_xpath("elibri:SaleNotRestricted")
            @unlimited_licence = true
          elsif date = data.at_xpath("elibri:SaleRestrictedTo").try(:text)
            @unlimited_licence = false
            @licence_limited_to_before_type_cast = date
            @licence_limited_to = Date.new(date[0...4].to_i, date[4...6].to_i, date[6...8].to_i)
          end
        end
        
        def descriptive_details_setup(data)
          @product_composition = data.at_xpath('xmlns:ProductComposition').try(:text)
          @product_form = data.at_xpath('xmlns:ProductForm').try(:text)
          @product_form_name = Elibri::ONIX::Dict::Release_3_0::ProductFormCode::find_by_onix_code(@product_form).name(:en).downcase
          @measures =  data.xpath('xmlns:Measure').map { |measure_data| Measure.new(measure_data) }
          @title_details = data.xpath('xmlns:TitleDetail').map { |title_data| TitleDetail.new(title_data) }
          @collections = data.xpath('xmlns:Collection').map { |collection_data| Collection.new(collection_data) }
          @contributors = data.xpath('xmlns:Contributor').map { |contributor_data| Contributor.new(contributor_data) }
          @no_contributor = !!data.at_xpath('xmlns:NoContributor')
          @languages = data.xpath('xmlns:Language').map { |language_data| Language.new(language_data) }
          @extents = data.xpath('xmlns:Extent').map { |extent_data| Extent.new(extent_data) }
          @subjects = data.xpath('xmlns:Subject').map { |subject_data| Subject.new(subject_data) }
          @audience_ranges = data.xpath('xmlns:AudienceRange').map { |audience_data| AudienceRange.new(audience_data) }

          if data.xpath("xmlns:ProductFormDetail").size > 0
            @digital_formats = []
            data.xpath("xmlns:ProductFormDetail").each do |format|
              @digital_formats << Elibri::ONIX::Dict::Release_3_0::ProductFormDetail::find_by_onix_code(format.text).name.upcase.gsub("MOBIPOCKET", "MOBI")
            end
          end
         
          #zabezpiecznie pliku
          if protection = data.at_xpath("xmlns:EpubTechnicalProtection").try(:text)
            @technical_protection =  Elibri::ONIX::Dict::Release_3_0::EpubTechnicalProtection::find_by_onix_code(protection).name
            @technical_protection_onix_code = protection
          end

          @edition_statement = data.at_xpath('xmlns:EditionStatement').try(:text)
          @number_of_illustrations = data.at_xpath('xmlns:NumberOfIllustrations').try(:text).try(:to_i)
        end
        
        def collateral_details_setup(data)
          @text_contents = data.xpath('xmlns:TextContent').map { |text_detail| TextContent.new(text_detail) }
          @supporting_resources = data.xpath('xmlns:SupportingResource').map { |supporting_data| SupportingResource.new(supporting_data) }
        end
        
        def publishing_details_setup(data)
          @imprint = Imprint.new(data.at_xpath('xmlns:Imprint')) if data.at_xpath('xmlns:Imprint')
          @publisher = Publisher.new(data.at_xpath('xmlns:Publisher')) if data.at_xpath('xmlns:Publisher')
          @publishing_status = data.at_xpath('xmlns:PublishingStatus').try(:text)
          @city_of_publication = data.at_xpath("xmlns:CityOfPublication").try(:text)
          @publishing_date = PublishingDate.new(data.at_xpath('xmlns:PublishingDate')) if data.at_xpath('xmlns:PublishingDate')
          @sales_restrictions = data.xpath('xmlns:SalesRestriction').map { |restriction_data| SalesRestriction.new(restriction_data) }      
          #ograniczenia terytorialne
          if data.at_xpath(".//xmlns:CountriesIncluded").try(:text) == "PL"
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

        #czy istnieje podgląd?
        def preview_exists?
          @preview_exists
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
  
          @elibri_product_category1_id = subjects[0].code if subjects[0]
          @elibri_product_category2_id = subjects[1].code if subjects[1]

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
