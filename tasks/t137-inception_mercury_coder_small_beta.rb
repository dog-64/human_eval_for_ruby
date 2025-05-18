def compare_one(a, b)
  a = a.to_f if a.is_a?(String)
  b = b.to_f if b.is_a?(String)
  return nil if a == b
  return a if a > b
  b
end