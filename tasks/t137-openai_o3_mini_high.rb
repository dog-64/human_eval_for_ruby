def compare_one(a, b)
  a_val = a.is_a?(String) ? a.gsub(',', '.').to_f : a.to_f
  b_val = b.is_a?(String) ? b.gsub(',', '.').to_f : b.to_f
  return nil if a_val == b_val
  a_val > b_val ? a : b
end