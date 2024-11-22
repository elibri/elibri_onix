module Inspector

  def attribute_for_inspect(attr_name)
    value = self.send(attr_name)

    if value.is_a?(String) && value.length > 50
      "#{value[0..50]}...".inspect
    elsif value.is_a?(Date) || value.is_a?(Time)
      %("#{value}")
    else
      value.inspect
    end
  end

  def inspect
    if self.respond_to?(:inspect_include_fields)
      attributes_as_nice_string = self.inspect_include_fields.collect { |name|
        "#{name}: #{attribute_for_inspect(name)}"
      }.compact.join(", ")
      "#<#{self.class} #{attributes_as_nice_string}>"
    else
      super
    end
  end
end

