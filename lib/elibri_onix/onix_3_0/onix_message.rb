
module Elibri
  module ONIX
    module Release_3_0

      #class representing whole ONIX response from eLibri server
      class ONIXMessage   
        #list of all products returned in this mnessage
        attr_accessor :products

        #xml representation of this message
        attr_accessor :to_xml

        #ONIX version number 
        attr_accessor :release

        #:nodoc:
        attr_accessor :elibri_dialect

        #returned message header - Elibri::ONIX::Release_3_0::Header
        attr_accessor :header
        
        include HashId
         
        #:nodoc:
        ATTRIBUTES = [
          :release, :elibri_dialect, :header
        ]
        
        #:nodoc:
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
