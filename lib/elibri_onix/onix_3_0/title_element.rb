
module Elibri
  module ONIX
    module Release_3_0

      class TitleElement
        include ROXML
        include Inspector

        xml_name 'TitleElement'

        xml_accessor :level, :from => 'TitleElementLevel'
        xml_accessor :part_number, :from => 'PartNumber'
        xml_accessor :title, :from => 'TitleText'
        xml_accessor :subtitle, :from => 'Subtitle'


        def full_title
          String.new(self.title.to_s).tap do |_full_title|
            _full_title << ". " + self.subtitle if self.subtitle.present?
            _full_title << " (#{self.part_number})" if self.part_number.present?
          end
        end

      end

    end
  end
end
