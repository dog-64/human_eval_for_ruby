def any_int?(x, y, z)
  x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer) && (x == y + z || x == z + y || y == x + z || y == z + x || z == x + y || z == y + x)
end
