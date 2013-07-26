

module Elibri
  module ONIX
    module Release_3_0

      class ExcerptInfo
        
        #Informacja o fragmencie publikacji (e-book)
                
        ATTRIBUTES = [
          :file_type, :file_size, :md5, :updated_at, :link
        ]
        
        RELATIONS = [
          :inspect_include_fields
        ]
        
        attr_accessor :file_type, :file_size, :md5, :updated_at, :link, :eid, :to_xml
        
        def initialize(data)
          @to_xml = data.to_s
          @file_type = data.attributes['file_type'].value
          @file_size = data.attributes['file_size'].value.to_i
          @md5 = data.attributes['md5'].value
          @updated_at = Time.parse(data.attributes['updated_at'].value)
          @link = data.text
          @eid = data.attributes['id'].value.to_i
        end

        def id
          Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
          eid
        end

        def inspect_include_fields
          [:link]
        end
    
      end

    end
  end
end
