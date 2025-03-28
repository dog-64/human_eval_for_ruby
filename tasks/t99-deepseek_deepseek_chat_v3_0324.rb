def closest_integer(value)
  num = value.to_f
  rounded = num.round
  if (num - rounded).abs == 0.5
    num.positive? ? rounded.ceil : rounded.floor
  else
    rounded
  end
end