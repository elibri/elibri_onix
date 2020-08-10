

%w{
    sender header product_identifier measure title_element title_detail collection contributor
    language extent audience_range text_content supporting_resource imprint publisher publishing_date
    sales_restriction related_product supplier_identifier stock_quantity_coded price supplier supply_detail
    product onix_message excerpt_info file_info thema_subject publisher_subject
  }.each do |file_name|
  require File.join(File.dirname(__FILE__), "onix_3_0", file_name)
end  
