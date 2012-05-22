module ExternalId
 
#  def self.included(base)
#    base.xml_accessor :id_before_type_cast, :from => "@sourcename"
#  end

  def self.included(base)
    base.send(:attr_accessor, :id_before_type_cast)
  end
  
  def set_eid(data)
    @id_before_type_cast = data.attr('sourcename')
  end

  def eid
    @id_before_type_cast.split(":")[1].to_i
  end
  
  def id
    Kernel.warn "[DEPRECATION] `id` is deprecated. Please use `eid` instead."
    eid
  end

end
