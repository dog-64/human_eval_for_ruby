def closest_integer(value)
  x = value.to_f
  lower = x.floor
  upper = x.ceil
  if (x - lower) == (upper - x)
    x >= 0 ? upper : lower
  elsif (x - lower) < (upper - x)
    lower
  else
    upper
  end
end