
module Elibri
  module ONIX
    module Release_3_0

      class TitleElement

        ATTRIBUTES = [
          :level, :part_number, :title, :subtitle, :full_title
        ]
        
        RELATIONS = []
        
        attr_accessor :level, :part_number, :title, :subtitle, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @level = data.at_xpath('xmlns:TitleElementLevel').try(:text)
          @part_number = data.at_xpath('xmlns:PartNumber').try(:text)
          @title = data.at_xpath('xmlns:TitleText').try(:text)
          @subtitle = data.at_xpath('xmlns:Subtitle').try(:text)
        end

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
