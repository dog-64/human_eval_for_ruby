
def compare_one(a, b)
  num_a = a.is_a?(String) ? a.tr(',', '.').to_f : a.to_f
  num_b = b.is_a?(String) ? b.tr(',', '.').to_f : b.to_f
  
  return nil if num_a == num_b
  
  num_a > num_b ? a : b
end