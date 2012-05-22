

module Elibri
  module ONIX
    module Release_3_0

      class SupportingResource
        include ExternalId
        include ExternalTimestamp
        
        ATTRIBUTES = [
          :content_type, :mode, :form, :link, :content_type_name, :mode_name, :form_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :content_type, :mode, :form, :link, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @content_type = data.at_xpath('xmlns:ResourceContentType').try(:text)
          @mode = data.at_xpath('xmlns:ResourceMode').try(:text)
          @form = data.at_xpath('xmlns:ResourceVersion').at_xpath('xmlns:ResourceForm').try(:text)
          @link = data.at_xpath('xmlns:ResourceVersion').at_xpath('xmlns:ResourceLink').try(:text)
          set_eid(data)
          set_datestamp(data)
        end

        def content_type_name
          Elibri::ONIX::Dict::Release_3_0::ResourceContentType.find_by_onix_code(@content_type).const_name.downcase
        end
 
        #def audience_name
        #  Elibri::ONIX::Dict::Release_3_0::ContentAudience.find_by_onix_code(audience).const_name.downcase
        #end

        def mode_name
          Elibri::ONIX::Dict::Release_3_0::ResourceMode.find_by_onix_code(@mode).const_name.downcase
        end

        def form_name
          Elibri::ONIX::Dict::Release_3_0::ResourceForm.find_by_onix_code(@form).const_name.downcase
        end

        def inspect_include_fields
          [:content_type_name, :mode_name, :form_name]
        end
      end
    end
  end
end
