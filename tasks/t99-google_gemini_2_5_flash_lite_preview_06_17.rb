def closest_integer(value)
  float_value = value.to_f
  if float_value.to_s == float_value.round.to_s
    float_value.round
  else
    if float_value > 0
      (float_value + 0.5).floor
    else
      (float_value - 0.5).ceil
    end
  end
end