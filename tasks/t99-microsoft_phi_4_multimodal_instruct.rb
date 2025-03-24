def closest_integer(value)
  number = value.to_f
  lower = (number.to_i).to_f
  upper = lower.to_f + 1
  return lower if (number - lower).abs < (upper - number).abs
  return upper
end
