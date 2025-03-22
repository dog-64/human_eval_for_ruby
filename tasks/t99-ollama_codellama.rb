def closest_integer(value)
  value = Float(value)
  if value > 0
    (value.ceil + value.floor) / 2.0
  else
    (value.ceil - value.floor) / 2.0
  end
end
