
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

        xml_accessor :product_composition, :in => 'DescriptiveDetail', :from => 'ProductComposition', :as => Fixnum
        xml_accessor :product_form, :in => 'DescriptiveDetail', :from => 'ProductForm'
        xml_accessor :measures, :in => 'DescriptiveDetail', :as => [Measure]
        xml_accessor :title_details, :in => 'DescriptiveDetail', :as => [TitleDetail]
        xml_accessor :collections, :in => 'DescriptiveDetail', :as => [Collection]
        xml_accessor :contributors, :in => 'DescriptiveDetail', :as => [Contributor]
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
        xml_accessor :publishing_status, :in => 'PublishingDetail', :from => 'PublishingStatus', :as => Fixnum
        xml_accessor :publishing_date, :in => 'PublishingDetail', :as => PublishingDate
        xml_accessor :sales_restrictions, :in => 'PublishingDetail', :as => [SalesRestriction]

        def full_title
          title_details.find {|title_detail| title_detail.type == 1}.try(:full_title)
        end


        def original_title
          title_details.find {|title_detail| title_detail.type == 3}.try(:full_title)
        end


        def trade_title
          title_details.find {|title_detail| title_detail.type == 10}.try(:full_title)
        end


        def number_of_pages
          extents.find {|extent| extent.type == 0}.try(:value)
        end


        def reading_age_from
          age_from = audience_ranges.find {|audience_range| (audience_range.qualifier == 18) && (audience_range.precision == 3)}.try(:value)
          age_from.present? ? age_from.to_i : nil
        end


        def reading_age_to
          age_to = audience_ranges.find {|audience_range| (audience_range.qualifier == 18) && (audience_range.precision == 4)}.try(:value)
          age_to.present? ? age_to.to_i : nil
        end


        def imprint_name
          imprint.try(:name)
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
