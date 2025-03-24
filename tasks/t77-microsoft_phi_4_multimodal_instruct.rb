def is_cube?(a)
  n = a.abs.to_f(2).floor(3).pow(1/3)
  n.to_i**3 == a
end