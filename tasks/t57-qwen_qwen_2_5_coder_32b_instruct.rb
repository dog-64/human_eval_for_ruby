def monotonic?(arr)
  return true if arr.size <= 1

  increasing = decreasing = true

  (1...arr.size).each do |i|
    increasing = false if arr[i] < arr[i - 1]
    decreasing = false if arr[i] > arr[i - 1]
  end

  increasing || decreasing
end