def any_int?(x, y, z)
  return false unless [x, y, z].all? { |num| num.is_a?(Integer) }
  [x, y, z].permutation.any? { |a, b, c| a == b + c }
end