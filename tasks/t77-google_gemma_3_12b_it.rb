def is_cube?(a)
  return true if a == 0
  root = a**(1.0/3.0)
  root == root.round
end
