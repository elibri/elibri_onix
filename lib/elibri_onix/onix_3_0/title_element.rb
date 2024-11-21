module Elibri
  module ONIX
    module Release_3_0
      class TitleElement

        attr_accessor :level, :part_number, :title, :subtitle, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @level = data.at_css('TitleElementLevel')&.text
          @part_number = data.at_css('PartNumber')&.text
          @title = data.at_css('TitleText')&.text
          @subtitle = data.at_css('Subtitle')&.text
        end

        def full_title
          String.new(self.title.to_s.strip).tap do |_full_title|
            if _full_title =~ /[\.!\?]$/ #czy kończy się ?!.
              _full_title << " " + self.subtitle if self.subtitle && self.subtitle.size > 0
            else
              _full_title << ". " + self.subtitle if self.subtitle && self.subtitle.size > 0
            end
            if self.part_number && self.part_number.size > 0
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
