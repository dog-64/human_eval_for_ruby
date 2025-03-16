def move_one_ball(arr)
  n = arr.size
  return true if n <= 1
  count = 0
  n.times do |i|
    count += 1 if arr[i] > arr[(i + 1) % n]
  end
  count <= 1
end