def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  return s if n <= 1
  shift %= n
  shifted_s = s[-shift..-1] + s[0...-shift]
  shifted_s
end