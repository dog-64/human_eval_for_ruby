def compare_one(a, b)
  def to_float(value)
    if value.is_a?(String)
      value.gsub(',', '.').to_f
    else
      value.to_f
    end
  end

  float_a = to_float(a)
  float_b = to_float(b)

  if float_a > float_b
    a
  elsif float_b > float_a
    b
  else
    nil
  end
end