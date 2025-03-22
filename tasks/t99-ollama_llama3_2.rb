def closest_integer(value)
  num = value.to_f
  if num % 1 == 0
    return num
  else
    if num < 0
      return -((num + 1) / 2).to_i
    else
      return (num + 0.5).to_i
    end
  end
end