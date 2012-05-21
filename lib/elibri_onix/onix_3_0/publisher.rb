


module Elibri
  module ONIX
    module Release_3_0

      class Publisher
#        include ROXML
#        include Inspector

#        xml_name 'Publisher'
        
        ATTRIBUTES = [
          :role, :name, :id
        ]
        
        RELATIONS = []

        #występuje w tej chwili tylko 01 - główny wydawca
#        xml_accessor :role, :from => 'PublishingRole'
#        xml_accessor :name, :from => 'PublisherName'
#        xml_accessor :id,   :from => 'IDValue', :in => 'PublisherIdentifier', :as => Fixnum

        attr_accessor :role, :name, :id
        
        def initialize(data)
          @role = data.at_xpath('xmlns:PublishingRole').try(:text)
          @name = data.at_xpath('xmlns:PublisherName').try(:text)
          if data.at_xpath('xmlns:PublisherIdentifier')
            @id = data.at_xpath('xmlns:PublisherIdentifier').at_xpath('xmlns:IDValue').try(:text).try(:to_i)
          end
        end
        
      end

    end
  end
end
