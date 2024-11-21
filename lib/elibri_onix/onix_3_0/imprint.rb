module Elibri
  module ONIX
    module Release_3_0
      class Imprint

        attr_accessor :name, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          @name = data.at_css('ImprintName')&.text
        end

      end
    end
  end
end
