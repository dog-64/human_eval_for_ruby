def monotonic?(arr)
  return true if arr.size <= 1
  increasing = true
  decreasing = true
  (1...arr.size).each do |i|
    if arr[i] < arr[i - 1]
      increasing = false
    elsif arr[i] > arr[i - 1]
      decreasing = false
    end
  end
  increasing || decreasing
end