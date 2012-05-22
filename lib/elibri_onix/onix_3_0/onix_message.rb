
module Elibri
  module ONIX
    module Release_3_0

      class ONIXMessage        
        attr_accessor :release, :elibri_dialect, :products, :header, :to_xml

        ATTRIBUTES = [
          :release, :elibri_dialect, :header
        ]
        
        RELATIONS = [
          :products
        ]
        
        def self.from_xml(data, *initialization_args)
          self.new(data, *initialization_args)
        end

        def initialize(data, *initialization_args)
          @to_xml = data.to_s
          xml = Nokogiri::XML(data)
          onix_message = xml.children.first
          @release = onix_message['release']
          @elibri_dialect = onix_message.at_xpath('//elibri:Dialect').text
          @header = Header.new(onix_message.at_xpath('xmlns:Header'))
          @products = onix_message.xpath('xmlns:Product').map { |product_node| Product.new(product_node) }
        end


      end

    end
  end
end
