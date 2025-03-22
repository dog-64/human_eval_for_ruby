def move_one_ball(arr)
  return true if arr.empty?
  sorted_arr = arr.sort
  arr.length.times do |i|
    rotated_arr = arr[i..] + arr[0...i]
    return true if rotated_arr == sorted_arr
  end
  false
end