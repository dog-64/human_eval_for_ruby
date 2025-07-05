def closest_integer(value)
  value_float = value.to_f
  
  if value_float >= 0
    result = Math.floor(value_float)
    if Math.abs(value_float - result) < Math.abs(value_float - (result + 1))
      result
    else
      result + 1
    end
  else
    result = Math.ceil(value_float)
    if Math.abs(value_float - result) < Math.abs(value_float - (result - 1))
      result
    else
      result - 1
    end
  end
end
