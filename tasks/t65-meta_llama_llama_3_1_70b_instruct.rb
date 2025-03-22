def circular_shift(x, shift)
  str = x.to_s
  shift = shift % str.size
  str[-shift..] + str[...-shift]
end