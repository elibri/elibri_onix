
module Elibri
  module ONIX
    module Release_3_0

      class Product
        
        
        ATTRIBUTES =
        [
          :elibri_dialect, :height, :width, :thickness, :weight, :ean, :isbn13, :number_of_pages, :duration, 
          :file_size, :publisher_name, :publisher_id, :imprint_name, :current_state, :reading_age_from, :reading_age_to, 
          :table_of_contents, :description, :reviews, :excerpts, :series, :title, :subtitle, :collection_title,
          :collection_part, :full_title, :original_title, :trade_title, :parsed_publishing_date, :record_reference,
          :deletion_text, :cover_type, :cover_price, :vat, :pkwiu, :product_composition, :product_form, :imprint,
          :publisher, :product_form, :no_contributor, :edition_statement, :number_of_illustrations, :publishing_status,
          :publishing_date, :premiere, :front_cover, :series_names,
          :elibri_product_category1_id, :elibri_product_category2_id, :preview_exists, :short_description
        ]
        
        
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
               
        
#        include ROXML

        

        attr_accessor :elibri_dialect, :height, :width, :thickness, :weight, :ean, :isbn13, :number_of_pages, :duration, 
                      :file_size, :publisher_name, :publisher_id, :imprint_name, :current_state, :reading_age_from, :reading_age_to, 
                      :table_of_contents, :description, :reviews, :excerpts, :series, :title, :subtitle, :collection_title,
                      :collection_part, :full_title, :original_title, :trade_title, :short_description,
                      :elibri_product_category1_id, :elibri_product_category2_id, :preview_exists
                      
          
                      #from xml_accessor
        attr_accessor :record_reference, :notification_type, :deletion_text
        
                      # Load attributes specific for dialect 3.0.1
        attr_accessor :cover_type_from_3_0_1, :cover_price_from_3_0_1, :vat_from_3_0_1, :pkwiu_from_3_0_1, :preview_exists_from_3_0_1,
                      :product_composition, :product_form, :measures, :title_details, :collections, :contributors, :no_contributor,
                      :languages, :extents, :subjects, :audience_ranges, :edition_statement, :number_of_illustrations, :text_contents,
                      :supporting_resources, :imprint, :publisher, :publishing_status, :publishing_date, :sales_restrictions,
                      :identifiers, :related_products, :supply_details


        def initialize(data)
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
          @cover_type_from_3_0_1 = data.at_xpath('elibri:CoverType').try(:text)
          @cover_price_from_3_0_1 = BigDecimal.new(data.at_xpath('elibri:CoverPrice').try(:text)) if data.at_xpath('elibri:CoverPrice')
          @vat_from_3_0_1 = data.at_xpath('elibri:Vat').try(:text).try(:to_i)
          @pkwiu_from_3_0_1 = data.at_xpath('elibri:PKWiU').try(:text)
          @preview_exists_from_3_0_1 = data.at_xpath('elibri:preview_exists').try(:text)
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
          after_parse
        end
        
        def descriptive_details_setup(data)
          @product_composition = data.at_xpath('xmlns:ProductComposition').try(:text)
          @product_form = data.at_xpath('xmlns:ProductForm').try(:text)
          @measures =  data.xpath('xmlns:Measure').map { |measure_data| Measure.new(measure_data) }
          @title_details = data.xpath('xmlns:TitleDetail').map { |title_data| TitleDetail.new(title_data) }
          @collections = data.xpath('xmlns:Collection').map { |collection_data| Collection.new(collection_data) }
          @contributors = data.xpath('xmlns:Contributor').map { |contributor_data| Contributor.new(contributor_data) }
          @no_contributor = data.at_xpath('xmlns:NoContributor').try(:text)
          @languages = data.xpath('xmlns:Language').map { |language_data| Language.new(language_data) }
          @extents = data.xpath('xmlns:Extent').map { |extent_data| Extent.new(extent_data) }
          @subjects = data.xpath('xmlns:Subject').map { |subject_data| Subject.new(subject_data) }
          @audience_ranges = data.xpath('xmlns:AudienceRange').map { |audience_data| AudienceRange.new(audience_data) }
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
          @publishing_date = PublishingDate.new(data.at_xpath('xmlns:PublishingDate')) if data.at_xpath('xmlns:PublishingDate')
          @sales_restrictions = data.xpath('xmlns:SalesRestriction').map { |restriction_data| SalesRestriction.new(restriction_data) }      
        end

=begin
        xml_name 'Product'
        xml_accessor :record_reference, :from => 'RecordReference'
        xml_accessor :notification_type, :from => 'NotificationType'
        xml_accessor :deletion_text, :from => 'DeletionText'

        # Load attributes specific for dialect 3.0.1
        xml_accessor :cover_type_from_3_0_1, :from => 'elibri:CoverType'
        xml_accessor :cover_price_from_3_0_1, :from => 'elibri:CoverPrice', :as => BigDecimal
        xml_accessor :vat_from_3_0_1, :from => 'elibri:Vat', :as => Fixnum
        xml_accessor :pkwiu_from_3_0_1, :from => 'elibri:PKWiU'
        xml_accessor :preview_exists_from_3_0_1, :from => "elibri:preview_exists"
=end
        # Attributes in namespace elibri:* are specific for dialect >= 3.0.1.
        # If dialect is less than 3.0.1, returns nil.
        %w{cover_type cover_price vat pkwiu}.each do |method_name|
          module_eval(<<-EVAL_END, __FILE__, __LINE__ + 1)
            def #{method_name}                                      # def vat
              if @elibri_dialect.to_s >= '3.0.1'                    #   if @elibri_dialect.to_s >= '3.0.1'
                #{method_name}_from_3_0_1                           #     vat_from_3_0_1
              else                                                  #   else
                nil                                                 #     nil
              end                                                   #   end
            end                                                     # end
          EVAL_END
        end  
#        xml_accessor :identifiers, :as => [ProductIdentifier]
#        xml_accessor :related_products, :as => [RelatedProduct], :in => 'RelatedMaterial'
#        xml_accessor :supply_details, :as => [SupplyDetail], :in => 'ProductSupply'

#        xml_accessor :product_composition, :in => 'DescriptiveDetail', :from => 'ProductComposition'
#        xml_accessor :product_form, :in => 'DescriptiveDetail', :from => 'ProductForm'
#        xml_accessor :measures, :in => 'DescriptiveDetail', :as => [Measure]
#        xml_accessor :title_details, :in => 'DescriptiveDetail', :as => [TitleDetail]
#        xml_accessor :collections, :in => 'DescriptiveDetail', :as => [Collection]
#        xml_accessor :contributors, :in => 'DescriptiveDetail', :as => [Contributor]
#        xml_accessor :no_contributor, :in => 'DescriptiveDetail', :from => 'NoContributor'
#        xml_accessor :languages, :in => 'DescriptiveDetail', :as => [Language]
#        xml_accessor :extents, :in => 'DescriptiveDetail', :as => [Extent]
#        xml_accessor :subjects, :in => 'DescriptiveDetail', :as => [Subject]
#        xml_accessor :audience_ranges, :in => 'DescriptiveDetail', :as => [AudienceRange]
#        xml_accessor :edition_statement, :in => 'DescriptiveDetail', :from => 'EditionStatement'
#        xml_accessor :number_of_illustrations, :in => 'DescriptiveDetail', :from => 'NumberOfIllustrations', :as => Fixnum

#        xml_accessor :text_contents, :in => 'CollateralDetail', :as => [TextContent]
#        xml_accessor :supporting_resources, :in => 'CollateralDetail', :as => [SupportingResource]

#        xml_accessor :imprint, :in => 'PublishingDetail', :as => Imprint
#        xml_accessor :publisher, :in => 'PublishingDetail', :as => Publisher
#        xml_accessor :publishing_status, :in => 'PublishingDetail', :from => 'PublishingStatus'
#        xml_accessor :publishing_date, :in => 'PublishingDetail', :as => PublishingDate
 #       xml_accessor :sales_restrictions, :in => 'PublishingDetail', :as => [SalesRestriction]

        def sales_restrictions?
          sales_restrictions.size > 0
        end

        def no_contributor?
          no_contributor == ""
        end

        def unnamed_persons?
          contributors.size == 1 && contributors[0].unnamed_persons.present?
        end

        def authors
          unnamed_persons? ? ["praca zbiorowa"] : contributors.find_all { |c| c.role_name == "author" }.map(&:person_name)
        end

        [:ghostwriter, :scenarist, :originator, :illustrator, :photographer, :author_of_preface, :drawer, :cover_designer, 
         :inked_or_colored_by, :editor, :revisor, :translator, :editor_in_chief, :read_by].each do |role|
          define_method "#{role}s" do
            contributors.find_all { |c| c.role_name == role.to_s }.map(&:person_name)
          end
        end

        [:announced, :preorder, :published, :out_of_print].each do |state|
          define_method "#{state}?" do
            current_state == state
          end
        end

        def preview_exists?
          @preview_exists
        end

        def front_cover
          supporting_resources.find { |resource| resource.content_type_name == "front_cover" }
        end

        def series_names
          series.map { |series| series[0] }
        end

        def premiere
          Date.new(*parsed_publishing_date) if parsed_publishing_date.size == 3
        end
 
        def proprietary_identifiers 
          identifiers.find_all { |i| i.identifier_type == "proprietary" }.inject({}) { |res, ident| res[ident.type_name] = ident.value; res }
        end

        #I don't want to see roxml_references in output - it's faar to big output
        def pretty_print_instance_variables
          (instance_variables - ["@roxml_references", "@measures", "@identifiers", "@notification_type", "@publishing_status",
                                 "@elibri_dialect", "@product_composition", "@extents", "@publisher", "@imprint",
                                 "@audience_ranges", "@text_contents", "@collections", "@title_details", "@publishing_date"]).find_all { |varname|
              instance_variable_get(varname).present?
          }.sort
        end


        def pretty_print(pp)
          pp.object_address_group(self) {
            pp.seplist(self.pretty_print_instance_variables, lambda { pp.text ',' }) {|v|
              pp.breakable
              v = v.to_s if Symbol === v
              pp.text v
              pp.text '='
              pp.group(1) {
                pp.breakable ''
                pp.pp(self.instance_eval(v))
              }
            }
          }
        end

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
          @publisher_id = @publisher.id if publisher
          @imprint_name = @imprint.name if imprint
          @isbn13 = @identifiers.find { |identifier| identifier.identifier_type == "isbn13" }.try(:value)
          @reading_age_from = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "03")}.try(:value)
          @reading_age_to = @audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "04")}.try(:value)
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
          @preview_exists = (preview_exists_from_3_0_1 == "true")

          compute_state!
        end

        def compute_state!
          if notification_type == "01"
            @current_state = :announced
          elsif notification_type == "02"
            @current_state = :preorder
          else
            if publishing_status == "04"
              @current_state = :published
            elsif publishing_status == "07"
              @current_state = :out_of_print
            else
              raise "cannot determine the state of the product #{record_reference}"
            end
          end
        end
      end

    end
  end
end
