def closest_integer(value)
  num = value.to_f
  num.round(abs: true)
end