def monotonic?(arr)
  return true if arr.length <= 1
  increasing = decreasing = true
  
  (1...arr.length).each do |i|
    if arr[i] > arr[i - 1]
      decreasing = false
    elsif arr[i] < arr[i - 1]
      increasing = false
    end
  end
  
  increasing || decreasing
end