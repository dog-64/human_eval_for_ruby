def any_int?(x, y, z)
  return false unless [x, y, z].all? { |num| num.is_a?(Integer) }
  x + y == z || x + z == y || y + z == x
end