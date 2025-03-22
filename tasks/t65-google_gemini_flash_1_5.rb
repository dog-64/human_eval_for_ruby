def circular_shift(x, shift)
  x_str = x.to_s
  len = x_str.length
  shift %= len
  x_str[-shift..-1] + x_str[0..-shift-1]
end
