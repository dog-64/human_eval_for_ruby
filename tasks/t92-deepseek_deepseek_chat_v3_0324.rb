def any_int?(x, y, z)
  return false unless [x, y, z].all? { |num| num.is_a?(Integer) || (num.is_a?(Numeric) && num.to_i == num) }
  x_int = x.to_i
  y_int = y.to_i
  z_int = z.to_i
  (x_int + y_int == z_int) || (x_int + z_int == y_int) || (y_int + z_int == x_int)
end