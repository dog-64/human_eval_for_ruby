def closest_integer(value)
  num = value.to_f
  if num > 0
    num < num.floor + 0.5 ? num.floor : num.ceil
  else
    num > num.floor - 0.5 ? num.floor : num.ceil
  end
end