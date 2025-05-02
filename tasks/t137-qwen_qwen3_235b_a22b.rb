def compare_one(a, b)
  converted_a = case a
  when String then a.gsub(',', '.').to_f
  when Numeric then a.to_f
  end

  converted_b = case b
  when String then b.gsub(',', '.').to_f
  when Numeric then b.to_f
  end

  if converted_a > converted_b
    a
  elsif converted_b > converted_a
    b
  else
    nil
  end
end