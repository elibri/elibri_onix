
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
          String.new(self.title.to_s.strip).tap do |_full_title|
            if _full_title =~ /[\.!\?]$/ #czy kończy się ?!.
              _full_title << " " + self.subtitle if self.subtitle.present?
            else
              _full_title << ". " + self.subtitle if self.subtitle.present?
            end
            if self.part_number.present?
              if self.part_number.to_i.to_s == self.part_number
                _full_title << " (##{self.part_number})" 
              else
                _full_title << " (#{self.part_number})"
              end 
            end
          end
        end

      end

    end
  end
end
