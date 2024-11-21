module Elibri
  module ONIX
    module Release_3_0
      class ExcerptInfo

        include TimestampParser
        attr_accessor :file_type, :file_size, :md5, :updated_at, :link, :eid, :to_xml

        def initialize(data)
          @to_xml = data.to_s
          if data.name == "excerpt"
            @file_type = data.attributes['file_type'].value
            @file_size = data.attributes['file_size'].value.to_i
            @md5 = data.attributes['md5'].value
            @updated_at = parse_timestamp(data.attributes['updated_at'].value)
            @link = data.text
            @eid = data.attributes['id'].value.to_i
          elsif data.name == "ResourceVersion"

            last_updated_node = data.css("ContentDate").find { |date|
                   date.css("ContentDateRole").first.inner_text == Elibri::ONIX::Dict::Release_3_0::ContentDateRole::LAST_UPDATED }

            if last_updated_node
              @updated_at = parse_timestamp(last_updated_node.css("Date").first.inner_text)
            end
            @link = data.css("ResourceLink").first.text
            @eid =  @link.split("/")[4].to_i
            @file_type = @link.split(".").last + "_excerpt"
            data.css("ResourceVersionFeature").each do |feature|
              feature_type = feature.css("ResourceVersionFeatureType").first.inner_text
              feature_value = feature.css("FeatureValue").first.inner_text
              if feature_type == Elibri::ONIX::Dict::Release_3_0::ResourceVersionFeatureType::MD5_HASH_VALUE
                @md5 = feature_value
              elsif feature_type == Elibri::ONIX::Dict::Release_3_0::ResourceVersionFeatureType::SIZE_IN_BYTES
                @file_size = feature_value.to_i
              end
            end
          else
            raise ArgumentError, "Unknow element for ExcerptInfo: #{data.name}"
          end
        end

        def inspect_include_fields
          [:link]
        end

      end
    end
  end
end
