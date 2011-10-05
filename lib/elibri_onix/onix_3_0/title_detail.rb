

module Elibri
  module ONIX
    module Release_3_0

      class TitleDetail
        include ROXML

        xml_name 'TitleDetail'

        xml_accessor :type, :from => 'TitleType', :as => Fixnum
        xml_accessor :elements, :as => [TitleElement]


        def full_title
          String.new.tap do |_full_title|
            _full_title << collection_level_title if collection_level_title.present?
            if product_level_title.present?
              _full_title << ". " if _full_title.present?
              _full_title << product_level_title 
            end
          end
        end


        private

          def product_level_title
            elements.find {|element| element.level == 1}.try(:full_title)
          end


          def collection_level_title
            elements.find {|element| element.level == 2}.try(:full_title)
          end

      end

    end
  end
end
