
def can_arrange(arr)
    (1...arr.length).each do |i|
        if arr[i-1] > arr[i]
            return i
        end
    end
    -1
end