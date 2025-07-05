def compare_one(a, b)
  def parse_number(val)
    if val.is_a?(String)
      val = val.gsub(',', '.')
      Float(val)
    else
      val
    end
  end

  parsed_a = parse_number(a)
  parsed_b = parse_number(b)

  if parsed_a == parsed_b
    nil
  elsif parsed_a > parsed_b
    a
  else
    b
  end
end