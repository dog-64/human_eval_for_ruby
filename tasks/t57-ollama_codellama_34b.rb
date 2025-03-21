[PYTHON]
def monotonic?(arr)
    return true if arr.size <= 1
    is_increasing = arr[0] <= arr[1]
    (2..arr.size-1).each do |i|
        if is_increasing && arr[i-1] > arr[i] || !is_increasing && arr[i-1] < arr[i]
            return false
        end
    end
    true
end
[/PYTHON]
