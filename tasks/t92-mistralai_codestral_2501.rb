def any_int?(x, y, z)
  return false unless x.integer? && y.integer? && z.integer?
  x + y == z || x + z == y || y + z == x
end