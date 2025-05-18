def closest_integer(value)
  x = value.to_f
  integer_part = x.to_i
  decimal_part = x - integer_part
  if decimal_part.abs >= 0.5
    decimal_part > 0 ? integer_part + 1 : integer_part - 1
  else
    integer_part
  end
end