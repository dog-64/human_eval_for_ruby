def move_one_ball(arr)
  return true if arr.empty?

  sorted_arr = arr.sort
  n = arr.length

  n.times do |i|
    rotated_arr = arr.rotate(i)
    return true if rotated_arr == sorted_arr
  end

  false
end