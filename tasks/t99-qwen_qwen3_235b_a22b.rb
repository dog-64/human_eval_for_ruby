def closest_integer(value)
  num = value.to_f
  if (num * 2).to_i == num * 2
    half = (num * 2).to_i
    if half.odd?
      return num > 0 ? num