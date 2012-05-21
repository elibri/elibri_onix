
module Elibri
  module ONIX
    module Release_3_0

      class TextContent
#        include ROXML
#        include Inspector
#        include ExternalId
#        include ExternalTimestamp
#
#        xml_name 'TextContent'
#
#        xml_accessor :type, :from => 'TextType'
#        #xml_accessor :audience, :from => 'ContentAudience' - always unrestricted
#        xml_accessor :author, :from => 'TextAuthor'
#        xml_accessor :source_title, :from => 'SourceTitle'
#
#        xml_accessor :text, :from => 'Text', :cdata => true
#        xml_accessor :source_url, :from => '@sourcename', :in => 'Text'
        
        ATTRIBUTES = [
          :type, :author, :source_title, :text, :source_url, :type_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :type, :author, :source_title, :text, :source_url
        
        def initialize(data)
          @type = data.at_xpath('xmlns:TextType').try(:text)
          @author = data.at_xpath('xmlns:TextAuthor').try(:text)
          @source_title = data.at_xpath('xmlns:SourceTitle').try(:text)
          @text = data.at_xpath('xmlns:Text').try(:text) #cdata => true ?
          @source_url =  data.at_xpath('xmlns:Text').attribute('sourcename')
        end

        def type_name
          Elibri::ONIX::Dict::Release_3_0::OtherTextType.find_by_onix_code(@type).const_name.downcase
        end

 
        def inspect_include_fields
          [:type_name]
        end

        private
          def after_parse
            @text = @text.strip if @text
          end
      end

    end
  end
end
