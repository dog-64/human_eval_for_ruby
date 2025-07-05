def move_one_ball(arr)
  return true if arr.empty?
  n = arr.length
  sorted_arr = arr.sort
  (0...n).each do |i|
    rotated_arr = arr.rotate(i)
    return true if rotated_arr == sorted_arr
  end
  false
end
