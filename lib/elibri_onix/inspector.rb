module Inspector

  def attribute_for_inspect(attr_name)
    value = self.send(attr_name)

    if value.is_a?(String) && value.length > 50
      "#{value[0..50]}...".inspect
    elsif value.is_a?(Date) || value.is_a?(Time)
      %("#{value.to_s(:db)}")
    #elsif value.is_a?(Array)
    #  "\n    [" + value.map(&:inspect).join(",\n     ") + "]"
    else
      value.inspect
    end
  end

  def inspect
    include_fields = self.respond_to?(:inspect_include_fields) ? self.inspect_include_fields : []
    attributes_as_nice_string = (include_fields + self.roxml_references.map { |rr| rr.opts.attr_name }).collect { |name|
      "#{name}: #{attribute_for_inspect(name)}"
    }.compact.join(", ")
    "#<#{self.class} #{attributes_as_nice_string}>"
  end
end

