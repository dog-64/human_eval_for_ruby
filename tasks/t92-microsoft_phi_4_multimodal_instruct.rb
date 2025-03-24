def any_int?(x, y, z)
  (x + y == z) || (x + z == y) || (z + y == x) && x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer)
end
