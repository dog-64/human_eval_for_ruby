def is_cube?(a)
  return true if a == 0
  cube_root = a.abs ** (1.0 / 3.0)
  cube_root == cube_root.round
end