

module Elibri
  module ONIX
    module Release_3_0

      class Imprint
#        include ROXML
#        include Inspector
#
#        xml_name 'Imprint'
        
        ATTRIBUTES = [
          :name
        ]
        
        RELATIONS = []

#        xml_accessor :name, :from => 'ImprintName'

        attr_accessor :name
        
        def initialize(data)
          @name = data.at_xpath('xmlns:ImprintName').try(:text)
        end

      end

    end
  end
end
