def closest_integer(value)
  num = value.to_f
  floor_val = num.floor
  ceil_val = num.ceil

  if (num - floor_val).abs == (num - ceil_val).abs
    if num >= 0
      ceil_val
    else
      floor_val
    end
  elsif (num - floor_val).abs < (num - ceil_val).abs
    floor_val
  else
    ceil_val
  end
end