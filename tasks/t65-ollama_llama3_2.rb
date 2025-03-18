def circular_shift(x, shift)
  s = x.to_s
  shift = shift % s.size
  s[shift..-1] + s[0...shift]
end