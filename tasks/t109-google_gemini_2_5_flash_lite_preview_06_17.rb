def move_one_ball(arr)
  return true if arr.empty?
  sorted_arr = arr.sort
  (0...arr.length).any? do |i|
    shifted_arr = arr.rotate(i)
    shifted_arr == sorted_arr
  end
end