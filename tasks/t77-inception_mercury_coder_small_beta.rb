def is_cube?(a)
  cube_root = a ** (1.0 / 3)
  cube_root.round ** 3 == a
end