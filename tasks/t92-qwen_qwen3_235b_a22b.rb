def any_int?(x, y, z)
  return false unless [x, y, z].all? { |n| n.is_a?(Integer) }
  x == y + z || y == x + z || z == x + y
end