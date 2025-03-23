
def any_int?(x, y, z)
  return false unless x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer)
  return true if x == y + z
  return true if y == x + z
  return true if z == x + y
  false
end
