def monotonic?(arr)
  return true if arr.length <= 1

  is_increasing = true
  is_decreasing = true

  (0...arr.length - 1).each do |i|
    if arr[i] > arr[i + 1]
      is_increasing = false
    end
    if arr[i] < arr[i + 1]
      is_decreasing = false
    end
  end

  is_increasing || is_decreasing
end
