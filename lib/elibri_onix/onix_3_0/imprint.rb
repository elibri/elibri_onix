

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

        attr_accessor :name, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @name = data.at_xpath('xmlns:ImprintName').try(:text)
        end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end

      end

    end
  end
end
