def any_int?(x, y, z)
  return false unless x.is_a?(Integer) || (x.is_a?(Float) && x == x.to_i)
  return false unless y.is_a?(Integer) || (y.is_a?(Float) && y == y.to_i)
  return false unless z.is_a?(Integer) || (z.is_a?(Float) && z == z.to_i)

  x = x.to_i
  y = y.to_i
  z = z.to_i

  return true if x == y + z
  return true if y == x + z
  return true if z == x + y

  false
end