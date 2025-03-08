def any_int?(x, y, z)
  [x, y, z].all? { |n| n == n.to_i } && [x, y, z].combination(2).any? { |a, b| a + b == [x, y, z].select { |n| n!= a && n!= b }[0] }
end