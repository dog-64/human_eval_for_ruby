def circular_shift(x, shift)
  str_x = x.to_s
  len = str_x.length
  return str_x.reverse if shift >= len

  split_index = len - shift
  str_x[split_index..-1] + str_x[0...split_index]
end