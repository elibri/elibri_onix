

module Elibri
  module ONIX
    module Release_3_0

      class SupportingResource
        include ROXML

        xml_name 'SupportingResource'

        xml_accessor :content_type, :from => 'ResourceContentType', :as => Fixnum
        xml_accessor :audience, :from => 'ContentAudience', :as => Fixnum
        xml_accessor :mode, :from => 'ResourceMode', :as => Fixnum

        xml_accessor :form, :in => 'ResourceVersion', :from => 'ResourceForm', :as => Fixnum
        xml_accessor :link, :in => 'ResourceVersion', :from => 'ResourceLink'

      end

    end
  end
end
