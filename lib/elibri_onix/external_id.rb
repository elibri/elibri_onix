module ExternalId
 
  def self.included(base)
    base.send(:attr_accessor, :id_before_type_cast)
  end
  
  def set_eid(data)
    @id_before_type_cast = data.attr('sourcename')
  end

  def eid
    begin
      @id_before_type_cast.split(":")[1].to_i
    rescue
      nil
    end
  end
end
