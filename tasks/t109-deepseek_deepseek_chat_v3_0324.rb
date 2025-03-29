def move_one_ball(arr)
  return true if arr.empty?
  sorted = arr.sort
  (0...arr.size).each do |i|
    rotated = arr.rotate(-i)
    return true if rotated == sorted
  end
  false
end