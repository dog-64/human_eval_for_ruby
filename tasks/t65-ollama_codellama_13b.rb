def circular_shift(x, shift)
  x = x.to_s
  shift = shift % x.length
  return x[shift..-1] + x[0...shift] if shift < x.length
  x.reverse
end