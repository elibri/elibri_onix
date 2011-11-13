
module Elibri
  module ONIX
    module Release_3_0

      class Product
        include ROXML

        attr_accessor :elibri_dialect, :height, :width, :thickness, :weight, :ean, :isbn13

        xml_name 'Product'
        xml_accessor :record_reference, :from => 'RecordReference'
        xml_accessor :notification_type, :from => 'NotificationType'
        xml_accessor :deletion_text, :from => 'DeletionText'

        # Load attributes specific for dialect 3.0.1
        xml_accessor :cover_type_from_3_0_1, :from => 'elibri:CoverType'
        xml_accessor :cover_price_from_3_0_1, :from => 'elibri:CoverPrice', :as => BigDecimal
        xml_accessor :vat_from_3_0_1, :from => 'elibri:Vat', :as => Fixnum
        xml_accessor :pkwiu_from_3_0_1, :from => 'elibri:PKWiU'

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

        def current_state
          if notification_type == "01"
            :announced
          elsif notification_type == "02"
            :preorder
          else
            if publishing_status == "04"
              :published
            elsif publishing_status == "07"
              :out_of_print
            else
              raise "cannot determine the state of the product"
            end
          end
        end

        def sales_restrictions?
          sales_restrictions.size > 0
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

        def no_contributor?
          no_contributor == ""
        end

        def unnamed_persons?
          contributors.size == 1 && contributors[0].unnamed_persons.present?
        end

        def front_cover
          supporting_resources.find { |resource| resource.content_type_name == "front_cover" }.try(:link)
        end

        def series
          collections.map { |c| c.title_detail.elements[0] }
        end

        def series_names
          series.map(&:title)
        end
 
        def publisher_name
          publisher.name if publisher
        end

        def imprint_name
          imprint.name if imprint
        end


        def find_title(code)
          title_details.find {|title_detail| title_detail.type == code}
        end

        def title
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).product_level.try(:title)
        end

        def subtitle
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).product_level.try(:subtitle)
        end

        def collection_title
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).collection_level.try(:title)
        end

        def collection_part
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).collection_level.try(:part_number)
        end


        def full_title
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTINCTIVE_TITLE).try(:full_title)
        end


        def original_title
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::ORIGINAL_TITLE).try(:full_title)
        end


        def trade_title
          find_title(Elibri::ONIX::Dict::Release_3_0::TitleType::DISTRIBUTORS_TITLE).try(:full_title)
        end

        def proprietary_identifiers 
          identifiers.find_all { |i| i.identifier_type == "proprietary" }.inject({}) { |res, ident| res[ident.type_name] = ident.value; res }
        end

        def number_of_pages 
          extents.find {|extent| extent.type_name == "page_count" }.try(:value)
        end

        def duration
          extents.find {|extent| extent.type_name == "duration" }.try(:value)
        end

        def file_size
          extents.find {|extent| extent.type_name == "file_size" }.try(:value)
        end 

        def reading_age_from
          age_from = audience_ranges.find {|audience_range| (audience_range.qualifier == "18") && (audience_range.precision == "03")}.try(:value)
          age_from.present? ? age_from.to_i : nil
        end


        def reading_age_to
          age_to = audience_ranges.find {|audience_range| (audience_range.qualifier == "18") && (audience_range.precision == "04")}.try(:value)
          age_to.present? ? age_to.to_i : nil
        end


        def imprint_name
          imprint.try(:name)
        end

        def table_of_contents
          text_contents.find { |t| t.type_name == "table_of_contents" }.try(:text)
        end

        def description
          text_contents.find { |t| t.type_name == "main_description" }.try(:text)
        end

        def reviews
          text_contents.find_all { |t| t.type_name == "review" }.map { |t| [t.text, t.author] }
        end

        def excerpts
          text_contents.find_all { |t| t.type_name == "excerpt" }.map { |t| t.text }
        end
 
        #I don't want to see roxml_references in output - it's faar to big output
        def pretty_print_instance_variables
          (instance_variables - ["@roxml_references", "@measures", "@identifiers"]).sort
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

        private

        def after_parse
          %w{height width thickness weight}.each do |mn|
            instance_variable_set("@#{mn}", measures.find { |m| m.type_name == mn }.try(:measurement))
          end

          @ean = identifiers.find { |identifier| identifier.identifier_type == "ean" }.try(:value)
          @isbn13 = identifiers.find { |identifier| identifier.identifier_type == "isbn13" }.try(:value)
        end

      end

    end
  end
end
