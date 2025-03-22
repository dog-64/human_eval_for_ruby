def move_one_ball(arr)
  return true if arr.empty?

  sorted_arr = arr.sort
  n = arr.length

  n.times do |i|
    return true if arr.rotate(i) == sorted_arr
  end

  false
end