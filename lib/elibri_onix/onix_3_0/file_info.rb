module Elibri
  module ONIX
    module Release_3_0
      class FileInfo

        include TimestampParser

        attr_accessor :file_type, :file_size, :md5, :updated_at, :eid, :to_xml

        def initialize(data)
          @to_xml = data.to_s

          data.css("ResourceFileDate").each do |date|
            if date.css("ResourceFileDateRole").first.inner_text == Elibri::ONIX::Dict::Release_3_0::ContentDateRole::LAST_UPDATED
              @updated_at = parse_timestamp(date.css("Date").first.inner_text)
            end
          end

          data.css("ResourceFileFeature").each do |feat|
            ftype = feat.css("ResourceFileFeatureType").first.inner_text
            fvalue = feat.css("ResourceFileFeatureValue").first.inner_text

            if ftype == Elibri::ONIX::Dict::Release_3_0::ResourceFileFeatureType::EXACT_FILE_SIZE
              @file_size = fvalue.to_i
            elsif ftype == Elibri::ONIX::Dict::Release_3_0::ResourceFileFeatureType::MD5
              @md5 = fvalue
            end
          end

          fname = data.css("ResourceFileLink").first&.inner_text
          if fname
            if File.extname(fname) == ".zip"
              @file_type = "mp3_in_zip"
            else
              @file_type = File.extname(fname)[1..-1]
            end
          end

          data.css("ResourceIdentifier").each do |ident|
            if ident.css("ResourceIDType").first&.inner_text == Elibri::ONIX::Dict::Release_3_0::ResourceIDType::PROPRIETARY
              @eid = ident.css("IDValue").first&.inner_text&.to_i
            end
          end
        end

        def inspect_include_fields
          [:file_type]
        end

      end

    end
  end
end
