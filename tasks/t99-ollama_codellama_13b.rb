def closest_integer(value)
  value = Float(value)
  if value > 0
    (value.ceil + value.floor) / 2.0
  else
    (value.ceil - value.floor) / 2.0
  end
end
closest_integer("10")  => 10
closest_integer("15.3") => 15
closest_integer("14.5") => 15
closest_integer("-14.5") => -15
closest_integer("0.5") => 1
closest_integer("-0.5") => -1