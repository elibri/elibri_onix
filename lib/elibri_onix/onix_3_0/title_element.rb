
module Elibri
  module ONIX
    module Release_3_0

      class TitleElement
      
        #from ONIX documentation:
        #A repeatable group of data elements which together represent an element of a collection title.
        #At least one title element is mandatory in each occurrence of the <TitleDetail> composite.
        #An instance of the <TitleElement> composite must include at least one of: <PartNumber>; <YearOfAnnual>; <TitleText>, or <TitlePrefix> together
        #with <TitleWithoutPrefix>. In other words it must carry either the text of a title element or a part or year designation; and it may carry both.
        #A title element must be designated as belonging to product level, collection level, or subcollection level
        #(the first of these may not occur in a title element representing a collective identity, and the last-named may only occur
        #in the case of a multi-level collection).
        #In the simplest case, title detail sent in a <Collection> composite will consist of a single title element, at collection level.
        #However, the composite structure in ONIX 3.0 allows more complex combinations of titles and part designations in multi-level
        #collections to be correctly represented.


        include HashId

        ATTRIBUTES = [
          :level, :part_number, :title, :subtitle, :full_title
        ]
        
        RELATIONS = []
        
        attr_accessor :level, :part_number, :title, :subtitle, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @level = data.at_css('TitleElementLevel').try(:text)
          @part_number = data.at_css('PartNumber').try(:text)
          @title = data.at_css('TitleText').try(:text)
          @subtitle = data.at_css('Subtitle').try(:text)
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
