
module Elibri
  module ONIX
    module Release_3_0

      class TextContent
        include ExternalId
        include ExternalTimestamp
        include Inspector
         
        #from ONIX documentation:
        #An optional and repeatable group of data elements which together carry text related to the product.
  
        #:nodoc:    
        ATTRIBUTES = [
          :type, :author, :source_title, :text, :source_url, :type_name
        ]
        
        #:nodoc:
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :type, :author, :source_title, :text, :source_url, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @type = data.at_css('TextType').try(:text)
          @author = data.at_css('TextAuthor').try(:text)
          @source_title = data.at_css('SourceTitle').try(:text)
          if data.at_css('Text')
            @text = data.at_css('Text').children.find { |x| x.cdata? }.try(:text) #cdata => true ?
            @source_url =  data.at_css('Text').attribute('sourcename').try(:text)
          end
          set_eid(data)
          set_datestamp(data)
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::OtherTextType.find_by_onix_code(@type).try(:const_name).try(:downcase)
        end

 
        def inspect_include_fields
          [:type_name, :text]
        end

        private
          def after_parse
            @text = @text.strip if @text
          end
      end

    end
  end
end
