def any_int?(x, y, z)
  return false unless x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer)

  x + y == z || x + z == y || y + z == x
end
