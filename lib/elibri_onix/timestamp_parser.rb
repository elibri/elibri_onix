module TimestampParser

  def parse_timestamp(value)
    year = value[0...4].to_i
    month = value[4...6].to_i
    day = value[6...8].to_i
    h = value[9...11].to_i
    m = value[11...13].to_i
    Time.new(year, month, day, h, m)
  end
end

