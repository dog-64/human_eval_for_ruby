def circular_shift(x, shift)
  x_str = x.to_s
  x_len = x_str.length
  shift = shift % x_len

  if shift == 0
    x_str
  else
    new_x_str = x_str[(x_len - shift)..-1] + new_x_str[0...x_len - shift]
    new_x_str
  end
end
