def any_int?(x, y, z)
  return false if x != Integer(x) || y != Integer(y) || z != Integer(z)
  [x, y, z].any? { |i| i == (x + y) || i == (y + z) || i == (z + x) }