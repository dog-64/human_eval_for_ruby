def any_int?(x, y, z)
  return false unless x.is_a?(Integer) && y.is_a?(Integer) && z.is_a?(Integer)
  [x, y, z].combination(2).any? { |a, b| a + b == [x, y, z].reject { |n| n == a || n == b }.first }
end