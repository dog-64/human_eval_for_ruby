def move_one_ball(arr)
  return true if arr.empty?

  sorted_arr = arr.sort
  (0...arr.length).any? { |i| arr.rotate(i) == sorted_arr }
end