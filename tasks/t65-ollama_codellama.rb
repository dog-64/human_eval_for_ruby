def circular_shift(x, shift)
  x = x.to_s
  shift = shift % x.length
  x[shift..-1] + x[0...shift]
end