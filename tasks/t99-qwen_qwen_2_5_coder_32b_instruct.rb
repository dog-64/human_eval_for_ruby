def closest_integer(value)
  num = value.to_f
  if num > 0
    (num + 0.5).floor
  else
    (num - 0.5).ceil
  end
end