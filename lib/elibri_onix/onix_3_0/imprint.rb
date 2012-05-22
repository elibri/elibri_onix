

module Elibri
  module ONIX
    module Release_3_0

      class Imprint
        
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
