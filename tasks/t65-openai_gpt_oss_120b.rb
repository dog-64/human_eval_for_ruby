def circular_shift(x, shift)
  digits = x.to_s
  len = digits.length
  return digits.reverse if shift > len
  s = shift % len
  return digits if s == 0
  tail = digits[-s, s]
  head = digits[0...-s]
  tail + head
end