

module Elibri
  module ONIX
    module Release_3_0

      class SupportingResource
        include ROXML
        include Inspector
        include ExternalId
        include ExternalTimestamp


        xml_name 'SupportingResource'

        xml_accessor :content_type, :from => 'ResourceContentType'
        #xml_accessor :audience, :from => 'ContentAudience' - always unrestricted
        xml_accessor :mode, :from => 'ResourceMode'

        xml_accessor :form, :in => 'ResourceVersion', :from => 'ResourceForm'
        xml_accessor :link, :in => 'ResourceVersion', :from => 'ResourceLink'
        
        ATTRIBUTES = [
          :content_type, :mode, :form, :link, :content_type_name, :mode_name, :form_name
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]

        def content_type_name
          Elibri::ONIX::Dict::Release_3_0::ResourceContentType.find_by_onix_code(content_type).const_name.downcase
        end
 
        #def audience_name
        #  Elibri::ONIX::Dict::Release_3_0::ContentAudience.find_by_onix_code(audience).const_name.downcase
        #end

        def mode_name
          Elibri::ONIX::Dict::Release_3_0::ResourceMode.find_by_onix_code(mode).const_name.downcase
        end

        def form_name
          Elibri::ONIX::Dict::Release_3_0::ResourceForm.find_by_onix_code(form).const_name.downcase
        end

        def inspect_include_fields
          [:content_type_name, :mode_name, :form_name]
        end
      end
    end
  end
end
