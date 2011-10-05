
module Elibri
  module ONIX
    module Release_3_0

      class Product
        include ROXML

        xml_name 'Product'
        xml_accessor :record_reference, :from => 'RecordReference'
        xml_accessor :notification_type, :from => 'NotificationType', :as => Fixnum
        xml_accessor :deletion_text, :from => 'DeletionText'

        xml_accessor :cover_type, :from => 'elibri:CoverType'
        xml_accessor :cover_price, :from => 'elibri:CoverPrice', :as => BigDecimal
        xml_accessor :vat, :from => 'elibri:Vat', :as => Fixnum
        xml_accessor :pkwiu, :from => 'elibri:PKWiU'

        xml_accessor :identifiers, :as => [ProductIdentifier]

        with_options :in => 'DescriptiveDetail' do |descriptive_detail|
          descriptive_detail.xml_accessor :product_composition, :as => Fixnum, :from => 'ProductComposition'
          descriptive_detail.xml_accessor :product_form, :from => 'ProductForm'
          descriptive_detail.xml_accessor :measures, :as => [Measure]
          descriptive_detail.xml_accessor :title_details, :as => [TitleDetail]
        end

        def isbn13
          identifiers.find {|identifier| identifier.id_type == 15}.try(:id_value)
        end


        def ean13
          identifiers.find {|identifier| identifier.id_type == 3}.try(:id_value)
        end


        %w{height width thickness weight}.each do |method_name|
          define_method(method_name) do
            send(method_name + '_measure').try(:measurement)
          end

          define_method(method_name + '_unit') do
            send(method_name + '_measure').try(:unit)
          end
        end  


        def proprietary_identifiers
          Hash.new.tap do |hash|
            identifiers.each do |identifier|
              hash[identifier.id_type_name] = identifier.id_value if identifier.id_type == 1
            end
          end
        end


        def full_title
          title_details.find {|title_detail| title_detail.type == 1}.try(:full_title)
        end


        def original_title
          title_details.find {|title_detail| title_detail.type == 3}.try(:full_title)
        end


        def trade_title
          title_details.find {|title_detail| title_detail.type == 10}.try(:full_title)
        end



        private

          def height_measure
            measures.find {|measure| measure.type == 1}
          end


          def width_measure
            measures.find {|measure| measure.type == 2}
          end


          def thickness_measure
            measures.find {|measure| measure.type == 3}
          end


          def weight_measure
            measures.find {|measure| measure.type == 8}
          end

      end

    end
  end
end
