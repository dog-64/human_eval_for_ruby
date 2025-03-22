def circular_shift(x, shift)
  s = x.to_s
  len = s.length
  return s.reverse if shift > len
  return s if shift == 0
  s[-shift..-1] + s[0...-shift]
end