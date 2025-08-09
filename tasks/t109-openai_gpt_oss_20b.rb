def move_one_ball(arr)
  return true if arr.empty?
  sorted = arr.sort
  n = arr.size
  start_index = sorted.index(arr[0])
  return false unless start_index
  n.times do |i|
    return false unless arr[i] == sorted[(start_index + i) % n]
  end
  true
end