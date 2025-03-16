def closest_integer(value)
  num = value.to_f
  int_part = num.to_i
  frac_part = num - int_part

  if frac_part.abs == 0.5
    if num > 0
      int_part + 1
    else
      int_part - 1
    end
  else
    num.round
  end
end