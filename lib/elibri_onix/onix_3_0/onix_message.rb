
module Elibri
  module ONIX
    module Release_3_0

      class ONIXMessage        
        attr_accessor :release, :elibri_dialect, :products, :header, :to_xml
        
        #class representing whole ONIX response from eLibri server
        
        include HashId
        
        ATTRIBUTES = [
          :release, :elibri_dialect, :header
        ]
        
        RELATIONS = [
          :products
        ]
        
        def self.from_xml(data, *initialization_args)
          Kernel.warn "[DEPRECATION] `from_xml` is deprecated. Please use `new` instead."
          self.new(data, *initialization_args)
        end

        def initialize(data, *initialization_args)
          @to_xml = data.to_s
          xml = Nokogiri::XML(data) unless xml.is_a?(Nokogiri::XML::Document)
          onix_message = xml.children.first
          @release = onix_message['release']
          @elibri_dialect = onix_message.at_xpath('elibri:Dialect').try(:text)
          @header = Header.new(onix_message.at_xpath('xmlns:Header')) if onix_message.at_xpath('xmlns:Header')
          @products = onix_message.xpath('xmlns:Product').map { |product_node| Product.new(product_node) }
        end


      end

    end
  end
end
