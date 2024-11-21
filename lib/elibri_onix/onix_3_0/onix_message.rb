module Elibri
  module ONIX
    module Release_3_0
      class ONIXMessage
        include Inspector

        #list of all products returned in this mnessage
        attr_accessor :products

        #xml representation of this message
        attr_accessor :to_xml

        #ONIX version number
        attr_accessor :release

        #returned message header - Elibri::ONIX::Release_3_0::Header
        attr_accessor :header

        # attributes of root ONIXMessage node
        attr_reader :attributes

        def inspect_include_fields
          [:header, :release, :products]
        end

        def initialize(xml, *initialization_args)
          @to_xml = xml.to_s
          xml = Nokogiri::XML(xml) unless xml.is_a?(Nokogiri::XML::Document)
          onix_message = xml.children.first
          @attributes = extract_attributes(onix_message.attribute_nodes)
          @release = onix_message['release']
          @header = Header.new(onix_message.at_css('Header')) if onix_message.at_css('Header')
          @products = onix_message.css('Product').map { |product_node| Product.new(product_node) }
        end

        private

        def extract_attributes(attr_nodes)
          attr_nodes.each_with_object({}) do |attr, memo|
            memo.merge! attribute_to_hash(attr)
          end
        end

        def attribute_to_hash(attr)
          name = attr.name
          namespace = attr.namespace.prefix if attr.namespace
          key = [namespace, name].compact.join(":")
          { key => attr.to_s }
        end
      end

    end
  end
end
