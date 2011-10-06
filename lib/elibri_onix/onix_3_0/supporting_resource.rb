

module Elibri
  module ONIX
    module Release_3_0

      class SupportingResource
        include ROXML

        xml_name 'SupportingResource'

        xml_accessor :content_type, :from => 'ResourceContentType', :as => Fixnum
        xml_accessor :audience, :from => 'ContentAudience', :as => Fixnum
        xml_accessor :mode, :from => 'ResourceMode', :as => Fixnum

        with_options :in => 'ResourceVersion' do |version|
          version.xml_accessor :form, :from => 'ResourceForm', :as => Fixnum
          version.xml_accessor :link, :from => 'ResourceLink'
        end

      end

    end
  end
end
