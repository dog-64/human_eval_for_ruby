def compare_one(a, b)
  return b if a == b
  a = a.to_f
  b = b.to_f
  return b.to_s if a == b
  a > b ? a : b
end
