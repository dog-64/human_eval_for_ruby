def compare_one(a, b)
  if a == b
    return nil
  end
  
  if a.is_a?(Numeric) && b.is_a?(Numeric)
    return a > b ? a : b
  elsif a.is_a?(String) && b.is_a?(String)
    return a.to_f > b.to_f ? a : b
  else
    raise ArgumentError, "Invalid input types"
  end
end