
def monotonic?(arr)
  return true if arr.length <= 1

  increasing = true
  decreasing = true

  (0...arr.length - 1).each do |i|
    if arr[i] > arr[i+1]
      increasing = false
    end
    if arr[i] < arr[i+1]
      decreasing = false
    end
    break if !increasing && !decreasing
  end

  increasing || decreasing
end