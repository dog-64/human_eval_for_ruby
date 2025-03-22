def move_one_ball(arr)
  return true if arr.empty?

  n = arr.length
  (0...n).each do |i|
    shifted_arr = arr.rotate(i)
    return true if shifted_arr == shifted_arr.sort
  end
  false
end