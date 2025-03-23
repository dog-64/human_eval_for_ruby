
def is_cube?(a)
  return true if a == 0
  
  cube_root = Math.round(Math.cbrt(a))
  
  cube_root**3 == a
end
