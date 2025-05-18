def any_int?(x, y, z)
  [x, y, z].all? { |num| num.is_a?(Integer) } && (x == y + z || y == x + z || z == x + y)
end