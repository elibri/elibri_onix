

module Elibri
  module ONIX
    module Release_3_0

      class Imprint
        
        #from ONIX documentation:
        #A repeatable group of data elements which together identify an imprint or brand under which the product is marketed.
        #The composite must carry either a name identifier or a name or both.
        
        ATTRIBUTES = [
          :name
        ]
        
        RELATIONS = []

        attr_accessor :name, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @name = data.at_xpath('xmlns:ImprintName').try(:text)
        end

      end

    end
  end
end
