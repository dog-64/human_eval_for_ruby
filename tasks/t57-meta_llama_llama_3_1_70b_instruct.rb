def monotonic?(arr)
  return true if arr.size <= 1
  up = down = true
  (1...arr.size).each do |i|
    up &&= arr[i] >= arr[i - 1]
    down &&= arr[i] <= arr[i - 1]
    return false unless up || down
  end
  true
end