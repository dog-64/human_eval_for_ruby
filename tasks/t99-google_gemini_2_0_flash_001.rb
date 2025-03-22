def closest_integer(value)
  float_value = value.to_f
  if float_value >= 0
    if float_value - float_value.to_i >= 0.5
      float_value.to_i + 1
    else
      float_value.to_i
    end
  else
    if float_value.to_i - float_value >= 0.5
      float_value.to_i - 1
    else
      float_value.to_i
    end
  end
end