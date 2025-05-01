def is_cube?(a)
  return true if a == 0
  sign = a.positive? ? 1 : -1
  abs_a = a.abs
  root = (abs_a**(1.0/3.0)).round
  (root**3) * sign == a
end