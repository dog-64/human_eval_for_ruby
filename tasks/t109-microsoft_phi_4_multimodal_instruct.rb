def move_one_ball(arr)
  return true if arr.empty?
  return arr == arr.sort if arr == arr.sort

  arr.each_cons(2).all? { |a, b| (b - a) % arr.size == 1 }
end