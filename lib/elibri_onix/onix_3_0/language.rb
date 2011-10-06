

module Elibri
  module ONIX
    module Release_3_0

      class Language
        include ROXML

        xml_name 'Language'

        xml_accessor :role, :from => 'LanguageRole', :as => Fixnum
        xml_accessor :code, :from => 'LanguageCode'

      end

    end
  end
end
