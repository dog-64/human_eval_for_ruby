def compare_one(a, b)
  a = a.to_s.gsub(',', '.').to_f if a.is_a?(String)
  b = b.to_s.gsub(',', '.').to_f if b.is_a?(String)

  return nil if a == b

  a > b ? (a.is_a?(String) ? a : a.to_s) : (b.is_a?(String) ? b : b.to_s)
end