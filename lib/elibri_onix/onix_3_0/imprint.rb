

module Elibri
  module ONIX
    module Release_3_0

      class Imprint
        include ROXML

        xml_name 'Imprint'

        xml_accessor :name, :from => 'ImprintName'

      end

    end
  end
end
