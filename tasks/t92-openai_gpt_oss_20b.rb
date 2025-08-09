def any_int?(x, y, z)
  integers = [x, y, z].all? do |n|
    n.is_a?(Integer) || (n.is_a?(Float) && n == n.to_i)
  end
  return false unless integers

  x == y + z || y == x + z || z == x + y
end