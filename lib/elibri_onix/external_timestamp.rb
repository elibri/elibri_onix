module ExternalTimestamp

  def self.included(base)
    base.send(:attr_accessor, :datestamp_before_type_cast) #, :from => "@datestamp"
  end
  
  def set_datestamp(data)
    @datestamp_before_type_cast = data.attr('datestamp')
  end

  def datestamp
    year = datestamp_before_type_cast[0...4].to_i
    month = datestamp_before_type_cast[4...6].to_i
    day = datestamp_before_type_cast[6...8].to_i
    h = datestamp_before_type_cast[9...11].to_i
    m = datestamp_before_type_cast[11...13].to_i

    Date.new(year, month, day) + h.hours + m.minutes
  end

end
