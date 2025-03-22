def monotonic?(arr)
    return true if arr.length <= 1
    increasing = true
    decreasing = true
    (1...arr.length).each do |i|
        if arr[i] > arr[i-1]
            decreasing = false
        elsif arr[i] < arr[i-1]
            increasing = false
        end
        break if !increasing && !decreasing
    end
    increasing || decreasing
end