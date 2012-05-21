
module Elibri
  module ONIX
    module Release_3_0

      class ONIXMessage
#        include ROXML
        #include Inspector

#        xml_name 'ONIXMessage'
#        xml_accessor :release, :from => "@release"
#        xml_accessor :elibri_dialect, :from => "elibri:Dialect"

#        xml_accessor :products, :as => [Product]
#        xml_accessor :header, :as => Header
        
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
          @to_xml = data
          xml = Nokogiri::XML(data)
          onix_message = xml.children.first
          @release = onix_message['release']
          @elibri_dialect = onix_message.at_xpath('//elibri:Dialect').text
          @header = Elibri::ONIX::Release_3_0::Header.new(onix_message.at_xpath('xmlns:Header'))
          @products = onix_message.xpath('xmlns:Product').map { |product_node| Elibri::ONIX::Release_3_0::Product.new(product_node) }
  #       @products = Elibri::ONIX::Release_3_0::Product.new(onix_message.xpath('//xmlns:Product'))
=begin
          xml = XML::Node.from(data)

          new(*initialization_args).tap do |inst|
            inst.roxml_references = roxml_attrs.map {|attr| attr.to_ref(inst) }

            inst.roxml_references.each do |ref|
              value = ref.value_in(xml)
              if ref.is_a? ROXML::XMLObjectRef
                Array(value).each do |obj|
                  obj.instance_variable_set(:@elibri_dialect, inst.elibri_dialect)
                end  
              end
              inst.respond_to?(ref.opts.setter) \
                ? inst.send(ref.opts.setter, value) \
                : inst.instance_variable_set(ref.opts.instance_variable_name, value)
            end
            inst.send(:after_parse) if inst.respond_to?(:after_parse, true)
          end
=end
#        rescue ArgumentError => e
#          raise e, e.message + " for class #{self}"
        end


      end

    end
  end
end
