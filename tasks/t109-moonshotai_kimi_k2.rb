def move_one_ball(arr)
  return true if arr.empty?
  
  n = arr.length
  sorted = arr.sort
  
  n.times do |i|
    rotated = arr.rotate(-i)
    return true if rotated == sorted
  end
  
  false
end