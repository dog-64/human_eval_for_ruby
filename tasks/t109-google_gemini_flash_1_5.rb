def move_one_ball(arr)
  return true if arr.empty?
  sorted_arr = arr.sort
  arr.length.times do
    return true if arr == sorted_arr
    arr = arr.rotate(-1)
  end
  false
end
