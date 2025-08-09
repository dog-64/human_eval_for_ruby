def closest_integer(value)
  f = value.to_f
  lower = f.floor
  upper = f.ceil
  return f.to_i if lower == upper
  diff_lower = f - lower
  diff_upper = upper - f
  if diff_lower < diff_upper
    lower
  elsif diff_lower > diff_upper
    upper
  else
    f > 0 ? upper : lower
  end
end