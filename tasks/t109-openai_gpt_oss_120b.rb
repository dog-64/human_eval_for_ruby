def move_one_ball(arr)
  return true if arr.empty?
  n = arr.length
  breaks = 0
  n.times do |i|
    breaks += 1 if arr[i] > arr[(i + 1) % n]
    return false if breaks > 1
  end
  true
end