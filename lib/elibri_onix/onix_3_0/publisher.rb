


module Elibri
  module ONIX
    module Release_3_0

      class Publisher
        
        #from ONIX documentation:
        #A repeatable group of data elements which together identify an entity which is associated with the publishing of a product.
        #The composite allows additional publishing roles to be introduced without adding new fields.
        #Each occurrence of the composite must carry a publishing role code and either a name identifier code or a name or both.
        

        include Inspector

        ATTRIBUTES = [
          :role, :name, :eid
        ]
        
        RELATIONS = []

        #role występuje w tej chwili tylko 01 - główny wydawca

        attr_accessor :role, :name, :eid, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @role = data.at_xpath('xmlns:PublishingRole').try(:text)
          @name = data.at_xpath('xmlns:PublisherName').try(:text)
          if data.at_xpath('xmlns:PublisherIdentifier')
            @eid = data.at_xpath('xmlns:PublisherIdentifier').at_xpath('xmlns:IDValue').try(:text).try(:to_i)
          end
        end

        def inspect_include_fields
          [:eid, :name]
        end
        
        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          @eid
        end
        
      end

    end
  end
end
