def move_one_ball(arr)
  return true if arr.empty?
  n = arr.size
  count = 0
  (0...n).each do |i|
    if arr[i] > arr[(i + 1) % n]
      count += 1
      return false if count > 1
    end
  end
  true
end