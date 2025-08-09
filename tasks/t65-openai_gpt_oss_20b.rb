def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  return s.reverse if shift > n
  shift %= n
  return s if shift.zero?
  s[-shift..-1] + s[0...-shift]
end