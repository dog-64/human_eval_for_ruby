
def any_int?(x, y, z)
  x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer) && (x == y + z || y == x + z || z == x + y)
end

 