def closest_integer(value)
  num = value.to_f
  
  if num == num.round
    return num.round
  elsif (num - num.round.abs) == (num.round - num.round.abs)
    return num.round.abs
  else
    return num.round
  end
end
