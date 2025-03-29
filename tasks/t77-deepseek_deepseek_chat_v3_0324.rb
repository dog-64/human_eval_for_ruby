def is_cube?(a)
  return true if a == 0
  (0..a.abs).each do |i|
    cube = i * i * i
    return true if cube == a
    return false if cube > a.abs
  end
  false
end