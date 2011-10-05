

%w{sender header product_identifier measure title_element title_detail product onix_message }.each do |file_name|
  require File.join(File.dirname(__FILE__), "onix_3_0", file_name)
end  
