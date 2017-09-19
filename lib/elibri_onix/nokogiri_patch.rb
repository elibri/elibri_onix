module Nokogiri
  module XML
    class Node
      alias_method :orig_xpath, :xpath

      def xpath(*paths)
        unless Nokogiri.uses_libxml?
          paths.each do |path|
            path.gsub!(/xmlns:/, ' :') if path.is_a?(String)
          end
        end
        orig_xpath(*paths)
      end

    end
  end
end
