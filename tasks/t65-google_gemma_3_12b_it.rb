def circular_shift(x, shift)
  x_str = x.to_s
  length = x_str.length
  shift %= length
  shifted_str = x_str[-shift..-1] + x_str[0...-shift]
  shifted_str
end
