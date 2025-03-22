def compare_one(a, b)
  a_value = a.is_a?(String) ? a.gsub(',', '.').to_f : a
  b_value = b.is_a?(String) ? b.gsub(',', '.').to_f : b

  return nil if a_value == b_value

  [a, b].max_by { |x| x.is_a?(String) ? x.gsub(',', '.').to_f : x }
end