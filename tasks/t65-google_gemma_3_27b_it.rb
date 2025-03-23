def circular_shift(x, shift)
  x_str = x.to_s
  n = x_str.length
  shift = shift % n
  if shift == 0
    return x_str
  else
    return x_str[-shift..-1] + x_str[0...-shift]
  end
end