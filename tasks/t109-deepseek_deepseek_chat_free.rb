def move_one_ball(arr)
  return true if arr.empty?
  n = arr.length
  sorted_arr = arr.sort
  n.times do |i|
    return true if arr == sorted_arr
    arr = [arr[-1]] + arr[0...-1]
  end
  false
end