module HashId
  
  SKIPPED_ATTRIBS = ["@opts", "@default_namespace", "@instance", "@roxml_references"]
  SKIPPED_2 = ["@id", "@id_before_type_cast"]

  def eid
    calculate_hash(self)
  end
  
  def calculate_hash(object)
    result = []
    if object.is_a? Array
      object.each { |x| result << calculate_hash(x) }
    else
      vars = []
      if object.class.to_s.include? "Elibri::ONIX"
        vars += object.class::ATTRIBUTES
        vars += object.class::RELATIONS
      end
      vars = object.instance_variables if vars.blank?
      vars.each do |attrib|
        next if SKIPPED_ATTRIBS.include? attrib
        next if SKIPPED_2.include? attrib
        attrib = attrib.to_s.gsub("@", "").to_sym if attrib.is_a?(String)
        if object.send(attrib).is_a? Array
          result << calculate_hash(object.send(attrib))
        elsif object.send(attrib).is_a?(String) || object.send(attrib).is_a?(Numeric) || object.send(attrib).is_a?(Fixnum) || object.send(attrib).is_a?(Symbol)
          result << object.send(attrib)
        else
          result << calculate_hash(object.send(attrib))
        end
      end
    end
    return Digest::SHA1.hexdigest(result.join("-"))
  end

end