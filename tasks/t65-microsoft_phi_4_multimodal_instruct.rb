def circular_shift(x, shift)
  s = String(x)
  shift = shift % s.size
  shift = s.size - shift if shift == 0
  s[shift..-1] + s[0...shift]
end