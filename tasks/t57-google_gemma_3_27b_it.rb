def monotonic?(arr)
  return true if arr.length <= 1

  increasing = true
  decreasing = true

  (1...arr.length).each do |i|
    increasing = false if arr[i] < arr[i - 1]
    decreasing = false if arr[i] > arr[i - 1]
  end

  increasing || decreasing
end