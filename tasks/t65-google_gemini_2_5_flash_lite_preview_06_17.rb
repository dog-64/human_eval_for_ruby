def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  if n == 0
    return ""
  end
  
  actual_shift = shift % n
  
  if actual_shift == 0
    s
  else
    s[-actual_shift..-1] + s[0...-actual_shift]
  end
end