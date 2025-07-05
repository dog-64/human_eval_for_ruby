def monotonic?(arr)
  return true if arr.empty? || arr.length == 1

  increasing = true
  decreasing = true

  (1...arr.length).each do |i|
    if arr[i] < arr[i - 1]
      increasing = false
    end
    if arr[i] > arr[i - 1]
      decreasing = false
    end
  end

  increasing || decreasing
end
