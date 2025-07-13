def closest_integer(value)
  num = value.to_f
  int_part = num.to_i
  
  if num >= 0
    (num - int_part) >= 0.5 ? int_part + 1 : int_part
  else
    (int_part - num) >= 0.5 ? int_part - 1 : int_part
  end
end