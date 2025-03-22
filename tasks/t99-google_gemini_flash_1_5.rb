def closest_integer(value)
  num = value.to_f
  int_part = num.floor
  decimal_part = num - int_part
  if decimal_part == 0.5
    (num > 0) ? int_part + 1 : int_part - 1
  elsif decimal_part < 0.5
    int_part
  else
    int_part + 1
  end
end
