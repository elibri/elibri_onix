module ExternalId
 
  def self.included(base)
    base.xml_accessor :id_before_type_cast, :from => "@sourcename"
  end

  def id
    id_before_type_cast.split(":")[1].to_i
  end

end
