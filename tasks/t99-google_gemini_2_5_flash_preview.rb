def closest_integer(value)
  num = value.to_f
  floor_num = num.floor
  ceil_num = num.ceil
  if (num - floor_num).abs == (num - ceil_num).abs
    if num >= 0
      ceil_num
    else
      floor_num
    end
  elsif (num - floor_num).abs < (num - ceil_num).abs
    floor_num
  else
    ceil_num
  end
end