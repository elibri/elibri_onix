
module Elibri
  module ONIX
    module Release_3_0

      class Product
        include ROXML

        attr_accessor :elibri_dialect, :height, :width, :thickness, :weight, :ean, :isbn13, :number_of_pages, :duration, 
                      :file_size, :publisher_name, :publisher_id, :imprint_name, :current_state, :reading_age_from, :reading_age_to, 
                      :table_of_contents, :description, :reviews, :excerpts, :series, :title, :subtitle, :collection_title,
                      :collection_part, :full_title, :original_title, :trade_title,
                      :elibri_product_category1_id, :elibri_product_category2_id, :preview_exists


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

        xml_accessor :identifiers, :as => [ProductIdentifier]
        xml_accessor :related_products, :as => [RelatedProduct], :in => 'RelatedMaterial'
        xml_accessor :supply_details, :as => [SupplyDetail], :in => 'ProductSupply'

        xml_accessor :product_composition, :in => 'DescriptiveDetail', :from => 'ProductComposition'
        xml_accessor :product_form, :in => 'DescriptiveDetail', :from => 'ProductForm'
        xml_accessor :measures, :in => 'DescriptiveDetail', :as => [Measure]
        xml_accessor :title_details, :in => 'DescriptiveDetail', :as => [TitleDetail]
        xml_accessor :collections, :in => 'DescriptiveDetail', :as => [Collection]
        xml_accessor :contributors, :in => 'DescriptiveDetail', :as => [Contributor]
        xml_accessor :no_contributor, :in => 'DescriptiveDetail', :from => 'NoContributor'
        xml_accessor :languages, :in => 'DescriptiveDetail', :as => [Language]
        xml_accessor :extents, :in => 'DescriptiveDetail', :as => [Extent]
        xml_accessor :subjects, :in => 'DescriptiveDetail', :as => [Subject]
        xml_accessor :audience_ranges, :in => 'DescriptiveDetail', :as => [AudienceRange]
        xml_accessor :edition_statement, :in => 'DescriptiveDetail', :from => 'EditionStatement'
        xml_accessor :number_of_illustrations, :in => 'DescriptiveDetail', :from => 'NumberOfIllustrations', :as => Fixnum

        xml_accessor :text_contents, :in => 'CollateralDetail', :as => [TextContent]
        xml_accessor :supporting_resources, :in => 'CollateralDetail', :as => [SupportingResource]

        xml_accessor :imprint, :in => 'PublishingDetail', :as => Imprint
        xml_accessor :publisher, :in => 'PublishingDetail', :as => Publisher
        xml_accessor :publishing_status, :in => 'PublishingDetail', :from => 'PublishingStatus'
        xml_accessor :publishing_date, :in => 'PublishingDetail', :as => PublishingDate
        xml_accessor :sales_restrictions, :in => 'PublishingDetail', :as => [SalesRestriction]

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
          title_details.find {|title_detail| title_detail.type == code}
        end

        def after_parse
          %w{height width thickness weight}.each do |mn|
            instance_variable_set("@#{mn}", measures.find { |m| m.type_name == mn }.try(:measurement))
          end

          @ean = identifiers.find { |identifier| identifier.identifier_type == "ean" }.try(:value)
          @isbn13 = identifiers.find { |identifier| identifier.identifier_type == "isbn13" }.try(:value)
          @number_of_pages = extents.find {|extent| extent.type_name == "page_count" }.try(:value)
          @duration = extents.find {|extent| extent.type_name == "duration" }.try(:value)
          @file_size = extents.find {|extent| extent.type_name == "file_size" }.try(:value)
          @publisher_name = publisher.name if publisher
          @publisher_id = publisher.id if publisher
          @imprint_name = imprint.name if imprint

          @reading_age_from = audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "03")}.try(:value)
          @reading_age_to = audience_ranges.find {|ar| (ar.qualifier == "18") && (ar.precision == "04")}.try(:value)
          @table_of_contents = text_contents.find { |t| t.type_name == "table_of_contents" }
          @description = text_contents.find { |t| t.type_name == "main_description" }
          @reviews = text_contents.find_all { |t| t.type_name == "review" }
          @excerpts = text_contents.find_all { |t| t.type_name == "excerpt" }
          @series = collections.map { |c| [c.title_detail.elements[0].title,  c.title_detail.elements[0].part_number] }
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
