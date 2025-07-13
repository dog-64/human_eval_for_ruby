def is_cube?(a)
  return true if a == 0
  root = a.abs ** (1.0 / 3)
  rounded_root = root.round
  rounded_root ** 3 == a
end